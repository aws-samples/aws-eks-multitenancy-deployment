<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.14 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_generate_known_hosts"></a> [generate\_known\_hosts](#module\_generate\_known\_hosts) | matti/resource/shell | 1.5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_codecommit_approval_rule_template.example_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_approval_rule_template) | resource |
| [aws_codecommit_approval_rule_template_association.example_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_approval_rule_template_association) | resource |
| [aws_codecommit_repository.gitops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_iam_policy.gitops_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.gitops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.gitops_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_ssh_key.gitops](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key) | resource |
| [aws_kms_key.secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [kubectl_manifest.cluster_secretstore](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.secret](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.platform_flux_tenant_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [tls_private_key.gitops](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_iam_policy_document.gitops_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the Kubernetes cluster, used for identification and management purposes. | `string` | `""` | no |
| <a name="input_cluster_secretstore_name"></a> [cluster\_secretstore\_name](#input\_cluster\_secretstore\_name) | The name of the secret store associated with the cluster for storing sensitive information. | `string` | `""` | no |
| <a name="input_cluster_secretstore_sa"></a> [cluster\_secretstore\_sa](#input\_cluster\_secretstore\_sa) | Service Account associated with the cluster's secret store for authentication and authorization. | `string` | `""` | no |
| <a name="input_iam_user_name"></a> [iam\_user\_name](#input\_iam\_user\_name) | The name assigned to the IAM user, which will be used for access and identity management. | `string` | `"fluxcd"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be deployed, affecting latency and availability. | `string` | `""` | no |
| <a name="input_repo_approvers_arn"></a> [repo\_approvers\_arn](#input\_repo\_approvers\_arn) | The ARN or ARN pattern for the IAM User/Role/Group that has the authority to approve Pull Requests in the repository. | `string` | n/a | yes |
| <a name="input_repository_description"></a> [repository\_description](#input\_repository\_description) | A brief description of the purpose and contents of the CodeCommit repository. | `string` | `"CodeCommit repository for hosting tenant apps"` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of the CodeCommit repository, used for identifying the repository. | `string` | `"cfg-multi-tenancy-apps"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ssh_public_key_id"></a> [aws\_ssh\_public\_key\_id](#output\_aws\_ssh\_public\_key\_id) | The SSH public key associated with the IAM user created by the GitOps module. |
| <a name="output_codecommit_repository_arn"></a> [codecommit\_repository\_arn](#output\_codecommit\_repository\_arn) | The ARN of the CodeCommit repository created by the GitOps module. |
| <a name="output_iam_user_name"></a> [iam\_user\_name](#output\_iam\_user\_name) | The name of the IAM user created by the GitOps module. |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The ARN of the KMS key created by the GitOps module. |
| <a name="output_platform_namespace_name"></a> [platform\_namespace\_name](#output\_platform\_namespace\_name) | The name of the platform namespace. |
<!-- END_TF_DOCS -->