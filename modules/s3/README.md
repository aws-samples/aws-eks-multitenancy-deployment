## Terraform Configuration

### Providers

| Provider | Version |
|---|---|


### Modules

| Module Name | Source | Version |
|---|---|---|


### Inputs

| Input Variable | Description |
|---|---|
| `project_name` | `Name of the project to be prefixed to create the s3 bucket` |
| `kms_key_arn` | `ARN of KMS key for encryption` |
| `tags` | `Tags to be associated with the S3 bucket` |
| `codepipeline_role_arn` | `ARN of the codepipeline IAM role` |

### Outputs

| Output Variable | Description |
|---|---|
| `bucket` | `The Name of the S3 Bucket` |
| `arn` | `The ARN of the S3 Bucket` |
| `bucket_url` | `Bucket url (auto-generated description)` |
