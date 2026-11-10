#!/bin/bash

# Variables
# Override any of these by exporting them before running the script.
REGION="${AWS_REGION:-us-west-2}"
ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
# Bucket names are globally unique; include account ID and Region to avoid name squatting.
S3_BUCKET_NAME="${TF_STATE_BUCKET:-amzn-s3-demo-tfstate-${ACCOUNT_ID}-${REGION}}"
DYNAMODB_TABLE_NAME="${TF_LOCK_TABLE:-terraform-locks}"

set -euo pipefail

# Create S3 Bucket
aws s3 mb "s3://${S3_BUCKET_NAME}" --region "${REGION}"

# Block all public access on the state bucket
aws s3api put-public-access-block --bucket "${S3_BUCKET_NAME}" \
    --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

# Enable Versioning on the S3 Bucket
aws s3api put-bucket-versioning --bucket ${S3_BUCKET_NAME} --versioning-configuration Status=Enabled

# Apply encryption using AWS Managed Keys (SSE-S3)
aws s3api put-bucket-encryption \
    --bucket ${S3_BUCKET_NAME} \
    --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'

# Create DynamoDB Table for Locks
aws dynamodb create-table \
    --table-name ${DYNAMODB_TABLE_NAME} \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --sse-specification Enabled=true,SSEType=KMS \
    --region ${REGION}

# Check if the table is created
echo "Checking if DynamoDB table is created..."
aws dynamodb describe-table --table-name ${DYNAMODB_TABLE_NAME} --region ${REGION}

echo "S3 bucket ${S3_BUCKET_NAME} and DynamoDB table ${DYNAMODB_TABLE_NAME} created successfully."
echo "Export TF_STATE_BUCKET=${S3_BUCKET_NAME} before running run.sh if you overrode the default name."
