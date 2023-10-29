output "codecommit_repository_arn" {
  description = "The ARN of the CodeCommit repository created by the GitOps module."
  value       = aws_codecommit_repository.gitops.arn
}

output "iam_user_name" {
  description = "The name of the IAM user created by the GitOps module."
  value       = aws_iam_user.gitops.name
}

output "aws_ssh_public_key_id" {
  description = "The SSH public key associated with the IAM user created by the GitOps module."
  value       = aws_iam_user_ssh_key.gitops.ssh_public_key_id
}

output "kms_key_arn" {
  description = "The ARN of the KMS key created by the GitOps module."
  value       = aws_kms_key.secrets.arn
}

output "platform_namespace_name" {
  description = "The name of the platform namespace."
  value       = kubernetes_namespace.platform_flux_tenant_config.metadata[0].name
}
