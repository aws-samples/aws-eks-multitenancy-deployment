output "codecommit_name" {
  value       = module.codecommit_infrastructure_source_repo.repository_name
  description = "The name of the created AWS CodeCommit repository."
}

output "codecommit_url" {
  value       = module.codecommit_infrastructure_source_repo.clone_url_http
  description = "The HTTP clone URL for the AWS CodeCommit repository."
}

output "codecommit_arn" {
  value       = module.codecommit_infrastructure_source_repo.arn
  description = "The Amazon Resource Name (ARN) of the AWS CodeCommit repository."
}

output "codebuild_name" {
  value       = module.codebuild_terraform.name
  description = "The name of the AWS CodeBuild project."
}

output "codebuild_arn" {
  value       = module.codebuild_terraform.arn
  description = "The ARN of the AWS CodeBuild project."
}

output "codepipeline_name" {
  value       = module.codepipeline_terraform.name
  description = "The name of the AWS CodePipeline."
}

output "codepipeline_arn" {
  value       = module.codepipeline_terraform.arn
  description = "The ARN of the AWS CodePipeline."
}

output "iam_arn" {
  value       = module.codepipeline_iam_role.role_arn
  description = "The ARN of the IAM role used by AWS CodePipeline."
}

output "kms_arn" {
  value       = module.codepipeline_kms.arn
  description = "The ARN of the AWS KMS key used in the CodePipeline."
}

output "s3_arn" {
  value       = module.s3_artifacts_bucket.arn
  description = "The ARN of the AWS S3 bucket used for storing artifacts."
}

output "s3_bucket_name" {
  value       = module.s3_artifacts_bucket.bucket
  description = "The name of the AWS S3 bucket used for storing pipeline artifacts."
}
