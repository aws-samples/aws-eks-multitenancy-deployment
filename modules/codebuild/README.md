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
| `vpc_enabled` | `Flag to enable or disable vpc config for codebuild projects` |
| `role_arn` | `Codepipeline IAM role arn. ` |
| `builder_compute_type` | `Information about the compute resources the build project will use` |
| `kms_key_arn` | `ARN of KMS key for encryption` |
| `vpc_name` | `Name of VPC for codebuild VPC access` |
| `builder_image_pull_credentials_type` | `Type of credentials AWS CodeBuild uses to pull images in your build.` |
| `builder_image` | `Docker image to use for the build project` |
| `project_name` | `Unique name for this project` |
| `tags` | `Tags to be applied to the codebuild project` |
| `build_project_source` | `Information about the build output artifact location` |
| `builder_type` | `Type of build environment to use for related builds` |
| `build_projects` | `List of Names of the CodeBuild projects to be created` |
| `s3_bucket_name` | `Name of the S3 bucket used to store the deployment artifacts` |

### Outputs

| Output Variable | Description |
|---|---|
| `name` | `List of Names of the CodeBuild projects` |
| `id` | `List of IDs of the CodeBuild projects` |
| `arn` | `List of ARNs of the CodeBuild projects` |
