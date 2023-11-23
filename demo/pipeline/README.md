## Terraform Configuration

### Providers

| Provider | Version |
|---|---|
| aws | `~> 4.0` |

### Modules

| Module Name | Source | Version |
|---|---|---|
| gitops | `../../modules/gitops` | `0.1` |
| s3_artifacts_bucket | `../../modules/s3` | `0.1` |
| codecommit_infrastructure_source_repo | `../../modules/codecommit` | `0.1` |
| codepipeline_kms | `../../modules/kms` | `0.1` |
| codepipeline_iam_role | `../../modules/iam-role` | `0.1` |

### Inputs

| Input Variable | Description |
|---|---|
| `environment` | `Environment to deploy the resources. This value is fetched from run.sh script` |
| `builder_compute_type` | `Relative path to the Apply and Destroy build spec file` |
| `builder_image_pull_credentials_type` | `Image pull credentials type used by codebuild project` |
| `builder_image` | `Docker Image to be used by codebuild` |
| `builder_type` | `Type of codebuild run environment` |
| `build_project_source` | `aws/codebuild/standard:4.0` |

### Outputs

| Output Variable | Description |
|---|---|
| `iam_arn` | `The ARN of the IAM Role used by the CodePipeline` |
| `kms_arn` | `The ARN of the KMS key used in the codepipeline` |
| `codepipeline_arn` | `The ARN of the CodePipeline` |
| `s3_bucket_name` | `The Name of the S3 Bucket` |
| `codebuild_arn` | `The ARN of the Codebuild Project` |
| `codepipeline_name` | `The Name of the CodePipeline` |
| `s3_arn` | `The ARN of the S3 Bucket` |
| `codecommit_arn` | `The ARN of the Codecommit repository` |
| `codecommit_name` | `The name of the Codecommit repository` |
| `codebuild_name` | `The Name of the Codebuild Project` |
| `codecommit_url` | `The Clone URL of the Codecommit repository` |
