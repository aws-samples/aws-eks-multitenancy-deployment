resource "aws_codebuild_project" "terraform_codebuild_project" {

  count = length(var.build_projects)

  name           = "${var.project_name}-${var.build_projects[count.index]}"
  service_role   = var.role_arn
  encryption_key = var.kms_key_arn
  tags           = var.tags
  artifacts {
    type = var.build_project_source
  }
  environment {
    compute_type = var.builder_compute_type
    image        = var.builder_image
    type         = var.builder_type
    # checkov:skip=CKV_AWS_316: Privileged mode necessary for this project
    privileged_mode             = true
    image_pull_credentials_type = var.builder_image_pull_credentials_type
  }
  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
  source {
    type      = var.build_project_source
    buildspec = "./templates/buildspec_${var.build_projects[count.index]}.yml"
  }

  dynamic "vpc_config" {
    for_each = local.vpc_config

    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
      vpc_id             = vpc_config.value.vpc_id
    }
  }
}
