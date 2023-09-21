#!/usr/bin/env bash

################################################################################
# Variables
################################################################################

RED='\033[0;31m'
BACKEND_BUCKET_ID="container-focus-group-tfstate"
DYNAMODB_ID="terraform-locks"

################################################################################
# Functions
################################################################################

function usage {
    echo "Usage: $(basename $0) [-app|env|region|tfcmd]" 2>&1
    echo ' -module      | -m        module to deploy eg: network'
    echo ' -env         | -e        environment to deploy eg: demo'
    echo ' -region      | -r        AWS region to deploy eg: us-west-2'
    echo ' -tfcmd       | -t        terraform command to run eg: init|plan|apply'
    exit 1
}

################################################################################
# Command Line Tool
################################################################################

if [[ ${#} -eq 0 ]]; then
    usage
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
    -module | -m)
        TF_MODULE=$2
        shift 2
        if [[ "$1" == "" || $2 = "" ]]; then
            echo -e "${RED}Error: Missing argument\n"
            usage
            break
        fi
        ;;
    -env | -e)
        TF_ENV=$2
        shift 2
        if [[ "$1" == "" || $2 = "" ]]; then
            echo -e "${RED}Error: Missing argument\n"
            usage
            break
        fi
        ;;

    -region | -r)
        TF_REGION=$2
        shift 2
        if [[ "$1" == "" || $2 = "" ]]; then
            echo -e "${RED}Error: Missing argument\n"
            usage
            break
        fi
        ;;

    -tfcmd | -t)
        TF_CMD=$2
        if [[ "$1" == "" || $2 = "" ]]; then
            echo -e "${RED}Error: Missing argument\n"
            usage
            break
        fi
        shift 2
        ;;
    *)
        usage
        ;;
    esac
done

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

TF_VARS_PATH="$DIR/$TF_ENV"
TF_EXECUTION_DIR="$DIR/$TF_ENV/$TF_MODULE"

# Always run from the location of this script
cd $DIR

if [ ! -d "$TF_EXECUTION_DIR" ]; then
    echo >&2 "Directory $TF_EXECUTION_DIR does not exist"
    usage
    exit 1
fi

if [ ! -d "$TF_VARS_PATH" ]; then
    echo >&2 "Directory $TF_VARS_PATH does not exist"
    usage
    exit 1
fi

# Set provider region and environment variable
export AWS_REGION=$TF_REGION
export TF_VAR_environment=$TF_ENV

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