## Terraform Configuration

### Providers

| Provider | Version |
|---|---|


### Modules

| Module Name | Source | Version |
|---|---|---|
| generate_known_hosts | `matti/resource/shell` | `1.5.0` |

### Inputs

| Input Variable | Description |
|---|---|
| `cluster_name` | `Name of the cluster` |
| `repository_description` | `Description of the CodeCommit repository` |
| `repo_approvers_arn` | `ARN or ARN pattern for the IAM User/Role/Group etc that can be used for approving Pull Requests` |
| `region` | `AWS region for the resources` |
| `iam_user_name` | `Name of the IAM user` |
| `cluster_secretstore_name` | `Name of the cluster secret store` |
| `cluster_secretstore_sa` | `Service Account for cluster secret store` |
| `repository_name` | `Name of the CodeCommit repository` |

### Outputs

| Output Variable | Description |
|---|---|
| `aws_ssh_public_key_id` | `The SSH public key associated with the IAM user created by the GitOps module.` |
| `platform_namespace_name` | `The name of the platform namespace.` |
| `kms_key_arn` | `The ARN of the KMS key created by the GitOps module.` |
| `iam_user_name` | `The name of the IAM user created by the GitOps module.` |
| `codecommit_repository_arn` | `The ARN of the CodeCommit repository created by the GitOps module.` |
