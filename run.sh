#!/usr/bin/env bash

# Variables
RED='\033[0;31m'
BACKEND_BUCKET_ID="container-focus-group-tfstate"
DYNAMODB_ID="terraform-locks"

# Functions
function usage {
    echo "Usage: $(basename "$0") [-module|-m] [-env|-e] [-region|-r] [-tfcmd|-t]" 2>&1
    echo ' -module | -m  module to deploy eg: network'
    echo ' -env    | -e  environment to deploy eg: demo'
    echo ' -region | -r  AWS region to deploy eg: us-west-2'
    echo ' -tfcmd  | -t  terraform command to run eg: init|plan|apply'
    exit 1
}

# Check for command-line arguments
if [[ $# -eq 0 ]]; then
    usage
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
    -module | -m)
        TF_MODULE=$2
        shift 2
        ;;
    -env | -e)
        TF_ENV=$2
        shift 2
        ;;
    -region | -r)
        TF_REGION=$2
        shift 2
        ;;
    -tfcmd | -t)
        TF_CMD=$2
        shift 2
        ;;
    *)
        usage
        ;;
    esac
done

# Validate and set directories
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TF_VARS_PATH="$DIR/$TF_ENV"
TF_EXECUTION_DIR="$DIR/$TF_ENV/$TF_MODULE"

# Always run from the location of this script
cd "$DIR" || exit 1

# Check if directories exist
if [ ! -d "$TF_EXECUTION_DIR" ] || [ ! -d "$TF_VARS_PATH" ]; then
    echo >&2 "Error: Directories $TF_EXECUTION_DIR or $TF_VARS_PATH do not exist"
    usage
fi

# Set provider region and environment variable
export AWS_REGION="$TF_REGION"
export TF_VAR_environment="$TF_ENV"

# Handle Terraform commands
if [ "$TF_CMD" == "init" ]; then
    terraform -chdir="$TF_EXECUTION_DIR" init \
        -backend-config="bucket=${BACKEND_BUCKET_ID}" \
        -backend-config="key=$TF_ENV/$TF_REGION/$TF_MODULE/terraform.tfstate" \
        -backend-config="dynamodb_table=${DYNAMODB_ID}" \
        -backend-config="region=$TF_REGION"
elif [ "$TF_CMD" == "plan" ]; then
    if [ "$TF_MODULE" == "pipeline" ]; then
        terraform -chdir="$TF_EXECUTION_DIR" "$TF_CMD"
    else
        terraform -chdir="$TF_EXECUTION_DIR" "$TF_CMD" -out tfapply
    fi
elif [ "$TF_CMD" == "apply" ]; then
    terraform -chdir="$TF_EXECUTION_DIR" "$TF_CMD" -input=false tfapply
elif [ "$TF_CMD" == "destroy" ]; then
    terraform -chdir="$TF_EXECUTION_DIR" "$TF_CMD" --auto-approve
else
    terraform -chdir="$TF_EXECUTION_DIR" "$TF_CMD"
fi