variable "repository_name" {
  description = "The name of the CodeCommit repository, used for identifying the repository."
  type        = string
  default     = "cfg-multi-tenancy-apps"
}

variable "repository_description" {
  description = "A brief description of the purpose and contents of the CodeCommit repository."
  type        = string
  default     = "CodeCommit repository for hosting tenant apps"
}

variable "iam_user_name" {
  description = "The name assigned to the IAM user, which will be used for access and identity management."
  type        = string
  default     = "fluxcd"
}

variable "cluster_secretstore_name" {
  description = "The name of the secret store associated with the cluster for storing sensitive information."
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region where the resources will be deployed, affecting latency and availability."
  type        = string
  default     = ""
}

variable "cluster_secretstore_sa" {
  description = "Service Account associated with the cluster's secret store for authentication and authorization."
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster, used for identification and management purposes."
  type        = string
  default     = ""
}

variable "repo_approvers_arn" {
  description = "The ARN or ARN pattern for the IAM User/Role/Group that has the authority to approve Pull Requests in the repository."
  type        = string
}
