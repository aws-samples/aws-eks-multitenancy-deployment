variable "environment" {
  description = "Environment to deploy the resources. This value is fetched from run.sh script"
  type        = string
  default     = ""
}

variable "backend_bucket_name" {
  description = "Name of the S3 bucket that stores Terraform state. This value is set by run.sh (TF_VAR_backend_bucket_name)."
  type        = string
}
