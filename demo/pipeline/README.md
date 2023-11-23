<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codebuild_terraform"></a> [codebuild\_terraform](#module\_codebuild\_terraform) | ../../modules/codebuild | n/a |
| <a name="module_codecommit_infrastructure_source_repo"></a> [codecommit\_infrastructure\_source\_repo](#module\_codecommit\_infrastructure\_source\_repo) | ../../modules/codecommit | n/a |
| <a name="module_codepipeline_iam_role"></a> [codepipeline\_iam\_role](#module\_codepipeline\_iam\_role) | ../../modules/iam-role | n/a |
| <a name="module_codepipeline_kms"></a> [codepipeline\_kms](#module\_codepipeline\_kms) | ../../modules/kms | n/a |
| <a name="module_codepipeline_terraform"></a> [codepipeline\_terraform](#module\_codepipeline\_terraform) | ../../modules/codepipeline | n/a |
| <a name="module_s3_artifacts_bucket"></a> [s3\_artifacts\_bucket](#module\_s3\_artifacts\_bucket) | ../../modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_build_project_source"></a> [build\_project\_source](#input\_build\_project\_source) | aws/codebuild/standard:4.0 | `string` | `"CODEPIPELINE"` | no |
| <a name="input_builder_compute_type"></a> [builder\_compute\_type](#input\_builder\_compute\_type) | Relative path to the Apply and Destroy build spec file | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_builder_image"></a> [builder\_image](#input\_builder\_image) | Docker Image to be used by codebuild | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:3.0"` | no |
| <a name="input_builder_image_pull_credentials_type"></a> [builder\_image\_pull\_credentials\_type](#input\_builder\_image\_pull\_credentials\_type) | Image pull credentials type used by codebuild project | `string` | `"CODEBUILD"` | no |
| <a name="input_builder_type"></a> [builder\_type](#input\_builder\_type) | Type of codebuild run environment | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy the resources. This value is fetched from run.sh script | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_arn"></a> [codebuild\_arn](#output\_codebuild\_arn) | The ARN of the AWS CodeBuild project. |
| <a name="output_codebuild_name"></a> [codebuild\_name](#output\_codebuild\_name) | The name of the AWS CodeBuild project. |
| <a name="output_codecommit_arn"></a> [codecommit\_arn](#output\_codecommit\_arn) | The Amazon Resource Name (ARN) of the AWS CodeCommit repository. |
| <a name="output_codecommit_name"></a> [codecommit\_name](#output\_codecommit\_name) | The name of the created AWS CodeCommit repository. |
| <a name="output_codecommit_url"></a> [codecommit\_url](#output\_codecommit\_url) | The HTTP clone URL for the AWS CodeCommit repository. |
| <a name="output_codepipeline_arn"></a> [codepipeline\_arn](#output\_codepipeline\_arn) | The ARN of the AWS CodePipeline. |
| <a name="output_codepipeline_name"></a> [codepipeline\_name](#output\_codepipeline\_name) | The name of the AWS CodePipeline. |
| <a name="output_iam_arn"></a> [iam\_arn](#output\_iam\_arn) | The ARN of the IAM role used by AWS CodePipeline. |
| <a name="output_kms_arn"></a> [kms\_arn](#output\_kms\_arn) | The ARN of the AWS KMS key used in the CodePipeline. |
| <a name="output_s3_arn"></a> [s3\_arn](#output\_s3\_arn) | The ARN of the AWS S3 bucket used for storing artifacts. |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | The name of the AWS S3 bucket used for storing pipeline artifacts. |
<!-- END_TF_DOCS -->