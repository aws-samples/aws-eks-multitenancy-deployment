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
| `stages` | `List of Map containing information about the stages of the CodePipeline` |
| `source_repo_branch` | `Default branch in the Source repo for which CodePipeline needs to be configured` |
| `kms_key_arn` | `ARN of KMS key for encryption` |
| `codepipeline_role_arn` | `ARN of the codepipeline IAM role` |
| `source_repo_name` | `Source repo name of the CodeCommit repository` |
| `project_name` | `Unique name for this project` |
| `tags` | `Tags to be attached to the CodePipeline` |
| `s3_bucket_name` | `S3 bucket name to be used for storing the artifacts` |

### Outputs

| Output Variable | Description |
|---|---|
| `name` | `The name of the CodePipeline` |
| `id` | `The id of the CodePipeline` |
| `arn` | `The arn of the CodePipeline` |
