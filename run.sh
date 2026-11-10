#!/usr/bin/env bash

################################################################################
# Variables
################################################################################

RED='\033[0;31m'
# State bucket and lock table must match the values used in bootstrap/bootstrap.sh.
# Defaults are derived after the Region is parsed; override with TF_STATE_BUCKET / TF_LOCK_TABLE.
BACKEND_BUCKET_ID="${TF_STATE_BUCKET:-}"
DYNAMODB_ID="${TF_LOCK_TABLE:-terraform-locks}"

################################################################################
# Functions
################################################################################

function usage {
    echo "Usage: $(basename "$0") [-module|-m] [-env|-e] [-region|-r] [-tfcmd|-t]" 2>&1
    echo ' -module | -m  module to deploy eg: network'
    echo ' -env    | -e  environment to deploy eg: demo'
    echo ' -region | -r  AWS region to deploy eg: us-west-2'
    echo ' -tfcmd  | -t  terraform command to run eg: init|plan|apply'
    exit 1
}

function validate_argument {
    if [[ -z "$1" || -z "$2" ]]; then
        echo -e "${RED}Error: Missing argument\n"
        usage
        exit 1
    fi
}

################################################################################
# Command Line Tool
################################################################################

if [[ $# -eq 0 ]]; then
    usage
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
    -module | -m)
        validate_argument "$1" "$2"
        TF_MODULE="$2"
        shift 2
        ;;

    -env | -e)
        validate_argument "$1" "$2"
        TF_ENV="$2"
        shift 2
        ;;

    -region | -r)
        validate_argument "$1" "$2"
        TF_REGION="$2"
        shift 2
        ;;

    -tfcmd | -t)
        validate_argument "$1" "$2"
        TF_CMD="$2"
        shift 2
        ;;

    *)
        usage
        ;;
    esac
done

DIR="$(cd "$(dirname "$0")" && pwd)"
TF_VARS_PATH="$DIR/$TF_ENV"
TF_EXECUTION_DIR="$DIR/$TF_ENV/$TF_MODULE"

# Always run from the location of this script
cd "$DIR" || exit 1

if [ ! -d "$TF_EXECUTION_DIR" ] || [ ! -d "$TF_VARS_PATH" ]; then
    echo >&2 "Error: Directories $TF_EXECUTION_DIR or $TF_VARS_PATH do not exist"
    usage
    exit 1
fi

# Set provider region and environment variable
export AWS_REGION="$TF_REGION"
export TF_VAR_environment="$TF_ENV"

if [ -z "$BACKEND_BUCKET_ID" ]; then
    ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
    BACKEND_BUCKET_ID="amzn-s3-demo-tfstate-${ACCOUNT_ID}-${TF_REGION}"
fi
export TF_VAR_backend_bucket_name="$BACKEND_BUCKET_ID"

if [ "$TF_CMD" == "init" ]; then
    terraform -chdir=$TF_EXECUTION_DIR init \
        -backend-config="bucket="${BACKEND_BUCKET_ID}"" \
        -backend-config="key=$TF_ENV/$TF_REGION/$TF_MODULE/terraform.tfstate" \
        -backend-config="dynamodb_table="${DYNAMODB_ID}"" \
        -backend-config="region=$TF_REGION"
elif [ "$TF_CMD" == "plan" ]; then
    terraform -chdir=$TF_EXECUTION_DIR $TF_CMD -out tfapply
elif [ "$TF_CMD" == "apply" ]; then
    terraform -chdir=$TF_EXECUTION_DIR $TF_CMD -input=false tfapply
elif [ "$TF_CMD" == "destroy" ]; then
    terraform -chdir=$TF_EXECUTION_DIR $TF_CMD --auto-approve
else
    terraform -chdir=$TF_EXECUTION_DIR $TF_CMD
fi

