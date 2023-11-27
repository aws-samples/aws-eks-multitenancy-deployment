#!/bin/bash

# Variables
S3_BUCKET_NAME="container-focus-group-tfstate"
DYNAMODB_TABLE_NAME="terraform-locks"
REGION="us-west-2"

# Create S3 Bucket
aws s3 mb "s3://${S3_BUCKET_NAME}" --region ${REGION}

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

echo "S3 bucket and DynamoDB table created successfully."
