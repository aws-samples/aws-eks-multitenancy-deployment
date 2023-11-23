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
| `create_new_role` | `Flag for deciding if a new role needs to be created` |
| `kms_key_arn` | `ARN of KMS key for encryption` |
| `codepipeline_iam_role_name` | `Name of the IAM role to be used by the project` |
| `source_repository_name` | `Name of the Source CodeCommit repository` |
| `project_name` | `Unique name for this project` |
| `tags` | `Tags to be attached to the IAM Role` |
| `s3_bucket_arn` | `The ARN of the S3 Bucket` |

### Outputs

| Output Variable | Description |
|---|---|
| `role_name` | `The ARN of the IAM Role` |
| `role_arn` | `The ARN of the IAM Role` |
