#!/bin/bash

# Accept Command Line Arguments
SKIPVALIDATIONFAILURE=$1
tfValidate=$2
tfFormat=$3
tfCheckov=$4
tfTfsec=$5
# -----------------------------

echo "### VALIDATION Overview ###"
echo "-------------------------"
echo "Skip Validation Errors on Failure : ${SKIPVALIDATIONFAILURE}"
echo "Terraform Validate : ${tfValidate}"
echo "Terraform Format   : ${tfFormat}"
echo "Terraform checkov  : ${tfCheckov}"
echo "Terraform tfsec    : ${tfTfsec}"
echo "------------------------"
terraform init

tfValidateOutput=0
tfFormatOutput=0
tfCheckovOutput=0
tfTfsecOutput=0

if [[ "${tfValidate}" == "Y" ]]; then
    echo "## VALIDATION : Validating Terraform code ..."
    terraform validate
    tfValidateOutput=$?
fi

if [[ "${tfFormat}" == "Y" ]]; then
    echo "## VALIDATION : Checking Terraform formatting ..."
    terraform fmt -recursive -check
    tfFormatOutput=$?
fi

if [[ "${tfCheckov}" == "Y" ]]; then
    echo "## VALIDATION : Running checkov ..."
    checkov -o junitxml --framework terraform -d ./ >checkov.xml
    tfCheckovOutput=$?
else
    touch checkov.xml
fi

if [[ "${tfTfsec}" == "Y" ]]; then
    echo "## VALIDATION : Running tfsec ..."
    tfsec ./ --format junit --out tfsec-junit.xml
    tfTfsecOutput=$?
else
    touch tfsec-junit.xml
fi

echo "## VALIDATION Summary ##"
echo "------------------------"
echo "Terraform Validate : ${tfValidateOutput}"
echo "Terraform Format   : ${tfFormatOutput}"
echo "Terraform checkov  : ${tfCheckovOutput}"
echo "Terraform tfsec    : ${tfTfsecOutput}"
echo "------------------------"

if [[ "${SKIPVALIDATIONFAILURE}" == "Y" ]]; then
    # If SKIPVALIDATIONFAILURE is set to Y, validation failures are reported but do not stop the build.
    echo "## WARNING : Skipping validation failure checks. Do not use this setting outside testing."
elif (( tfValidateOutput == 0 && tfFormatOutput == 0 && tfCheckovOutput == 0 && tfTfsecOutput == 0 )); then
    echo "## VALIDATION : Checks Passed!!!"
else
    # When validation checks fail, the build process is halted.
    echo "## ERROR : Validation Failed"
    exit 1
fi
