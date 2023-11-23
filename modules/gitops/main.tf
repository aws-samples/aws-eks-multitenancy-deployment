resource "aws_codecommit_approval_rule_template" "example_template" {
  name    = "example-approval-rule-template"
  content = <<JSON
{
  "Version": "2018-11-08",
  "DestinationReferences": ["refs/heads/main"],
  "Statements": [
    {
      "Type": "Approvers",
      "NumberOfApprovalsNeeded": 2,
      "ApprovalPoolMembers": ["${var.repo_approvers_arn}"]
    }
  ]
}
JSON
}

resource "aws_codecommit_approval_rule_template_association" "example_association" {
  approval_rule_template_name = aws_codecommit_approval_rule_template.example_template.name
  repository_name             = aws_codecommit_repository.gitops.repository_name
}

resource "aws_codecommit_repository" "gitops" {
  repository_name = var.repository_name
  description     = var.repository_description
}


resource "aws_iam_user" "gitops" {
  # checkov:skip=CKV_AWS_273: SSO access control not applicable
  name = var.iam_user_name
  path = "/"
}

resource "aws_iam_user_ssh_key" "gitops" {
  username   = aws_iam_user.gitops.name
  encoding   = "SSH"
  public_key = tls_private_key.gitops.public_key_openssh
}

resource "tls_private_key" "gitops" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "aws_iam_policy_document" "gitops_access" {
  statement {
    sid = "GitopsCodeCommmitAccess"
    actions = [
      "codecommit:GitPull",
      "codecommit:GitPush"
    ]
    effect    = "Allow"
    resources = [aws_codecommit_repository.gitops.arn]
  }
}

resource "aws_iam_policy" "gitops_access" {
  name   = "${aws_iam_user.gitops.name}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.gitops_access.json
}


resource "aws_iam_user_policy_attachment" "gitops_access" {
  # checkov:skip=CKV_AWS_40: IAM policies attached directly for specific reasons
  user       = aws_iam_user.gitops.name
  policy_arn = aws_iam_policy.gitops_access.arn
}

resource "aws_kms_key" "secrets" {
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.secretsmanager.json
}

resource "kubernetes_namespace" "platform_flux_tenant_config" {
  metadata {
    name = "platform-flux-tenant-config"
  }
}

resource "kubectl_manifest" "cluster_secretstore" {
  yaml_body = <<YAML
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: ${var.cluster_secretstore_name}
  namespace: ${kubernetes_namespace.platform_flux_tenant_config.metadata[0].name}
# checkov:skip=CKV2_AWS_57: Checkov check ignored based on project requirements.
spec:
  provider:
    aws:
      service: SecretsManager
      region: ${var.region}
      auth:
        jwt:
          serviceAccountRef:
# checkov:skip=CKV_TF_1: Checkov check ignored based on project requirements.
            name: ${var.cluster_secretstore_sa}
            namespace: external-secrets
YAML
}


resource "aws_secretsmanager_secret" "secret" {
  # checkov:skip=CKV2_AWS_57: Secret rotation not required
  recovery_window_in_days = 0
  kms_key_id              = aws_kms_key.secrets.arn
}


module "generate_known_hosts" {
  # checkov:skip=CKV_TF_1: Commit hash usage not applicable
  source  = "matti/resource/shell"
  version = "1.5.0"
  command = "ssh-keyscan -H git-codecommit.${var.region}.amazonaws.com"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode({
    "identity"     = tls_private_key.gitops.private_key_pem
    "identity.pub" = tls_private_key.gitops.public_key_openssh
    "known_hosts"  = module.generate_known_hosts.stdout
  })
}

resource "kubectl_manifest" "secret" {
  yaml_body  = <<YAML
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: ${var.cluster_name}-sm
  namespace: ${kubernetes_namespace.platform_flux_tenant_config.metadata[0].name}
spec:
    refreshInterval: 10m
    secretStoreRef:
        name: ${var.cluster_secretstore_name}
        kind: ClusterSecretStore
    target:
        name: ${var.cluster_name}-sm
        creationPolicy: Owner
    dataFrom:
        - extract:
              key: ${aws_secretsmanager_secret.secret.name}
YAML
  depends_on = [kubectl_manifest.cluster_secretstore]
}
