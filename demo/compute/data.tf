data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.backend_bucket_name
    key    = "${var.environment}/${local.region}/network/terraform.tfstate"
    region = local.region
  }
}

data "terraform_remote_state" "pipeline" {
  backend = "s3"
  config = {
    bucket = local.backend_bucket_name
    key    = "${var.environment}/${local.region}/pipeline/terraform.tfstate"
    region = local.region
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
