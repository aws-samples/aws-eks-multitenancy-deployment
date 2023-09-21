resource "aws_codecommit_repository" "gitops" {
  repository_name = "cfg-multi-tenancy-apps"
  description     = "CodeCommit repository for hosting tenant apps"
}

resource "aws_iam_user" "gitops" {
  name = "fluxcd"
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
  user       = aws_iam_user.gitops.name
  policy_arn = aws_iam_policy.gitops_access.arn
}

resource "aws_kms_key" "secrets" {
  enable_key_rotation = true
}

resource "kubectl_manifest" "cluster_secretstore" {
  yaml_body  = <<YAML
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: ${local.cluster_secretstore_name}
  namespace: platform-flux-tenant-config
spec:
  provider:
    aws:
      service: SecretsManager
      region: ${local.region}
      auth:
        jwt:
          serviceAccountRef:
            name: ${local.cluster_secretstore_sa}
            namespace: external-secrets
YAML
  depends_on = [module.eks_blueprints_addons]
}

resource "aws_secretsmanager_secret" "secret" {
  recovery_window_in_days = 0
  kms_key_id              = aws_kms_key.secrets.arn
}


module "generate_known_hosts" {
  source = "matti/resource/shell"

  command = "ssh-keyscan -H git-codecommit.${local.region}.amazonaws.com"
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
  name: ${local.cluster_name}-sm
  namespace: platform-flux-tenant-config
spec:
  refreshInterval: 10m
  secretStoreRef:
    name: ${local.cluster_secretstore_name}
    kind: ClusterSecretStore
  target:
    name: ${local.cluster_name}-sm
    creationPolicy: Owner
  dataFrom:
  - extract:
      key: ${aws_secretsmanager_secret.secret.name}
YAML
  depends_on = [kubectl_manifest.cluster_secretstore]
}
