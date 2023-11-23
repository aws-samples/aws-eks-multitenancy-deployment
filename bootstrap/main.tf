provider "aws" {
  region = "us-west-2" # Region has to be hardcoded because bootstrap is not done through run.sh script
}


resource "aws_kms_key" "example" {
  # checkov:skip=CKV2_AWS_64: KMS key policy not required as this is bucket is used for tfstate only
  description             = "KMS key for encrypting S3 and DynamoDB"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}


resource "aws_s3_bucket" "bucket" {
  # checkov:skip=CKV_AWS_18: Access logging not required
  # checkov:skip=CKV2_AWS_6: Public access block managed separately
  # checkov:skip=CKV_AWS_144: Cross-region replication not required for this bucket
  # checkov:skip=CKV2_AWS_61: Lifecycle rule is not required
  # checkov:skip=CKV2_AWS_62: Event notification is not required
  bucket = "container-focus-group-tfstate"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.example.arn
      }
    }
  }
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
  tags = {
    Name = "S3 Remote Terraform State Store"
  }

  # Public Access Block Configuration
  public_access_block {
    block_public_acls       = true
    ignore_public_acls      = true
    block_public_policy     = true
    restrict_public_buckets = true
  }
}


resource "aws_dynamodb_table" "terraform-lock" {
  # checkov:skip=CKV_AWS_28: DynamoDB backup is not required as this only for state locking
  # checkov:skip=CKV2_AWS_16: Auto Scaling is not required as this only for state locking
  name           = "terraform-locks"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.example.arn
  }
  tags = {
    "Name" = "DynamoDB Terraform State Lock Table"
  }
}
