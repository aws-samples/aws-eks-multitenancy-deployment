variable "repository_name" {
  description = "Name of the CodeCommit repository"
  type        = string
  default     = "cfg-multi-tenancy-apps"
}

variable "repository_description" {
  description = "Description of the CodeCommit repository"
  type        = string
  default     = "CodeCommit repository for hosting tenant apps"
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type        = string
  default     = "fluxcd"
}

variable "cluster_secretstore_name" {
  description = "Name of the cluster secret store"
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region for the resources"
  type        = string
  default     = ""
}

variable "cluster_secretstore_sa" {
  description = "Service Account for cluster secret store"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  default     = ""
}
