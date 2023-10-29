#Module for creating a new S3 bucket for storing pipeline artifacts
module "s3_artifacts_bucket" {
  source                = "../../modules/s3"
  project_name          = local.project_name
  kms_key_arn           = module.codepipeline_kms.arn
  codepipeline_role_arn = module.codepipeline_iam_role.role_arn
  tags = {
    Project_Name = local.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }
}

# Module for Infrastructure Source code repository
module "codecommit_infrastructure_source_repo" {
  source = "../../modules/codecommit"

  create_new_repo          = local.create_new_repo
  codecommit_description   = "Code Repository for hosting the terraform code and pipeline configuration files"
  source_repository_name   = local.source_repo_name
  source_repository_branch = local.source_repo_branch
  repo_approvers_arn       = local.repo_approvers_arn
  kms_key_arn              = module.codepipeline_kms.arn
  tags = {
    Project_Name = local.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }

}


# Module for Infrastructure Validation - CodeBuild
module "codebuild_terraform" {
  depends_on = [
    module.codecommit_infrastructure_source_repo
  ]
  source = "../../modules/codebuild"

  project_name                        = local.project_name
  role_arn                            = module.codepipeline_iam_role.role_arn
  s3_bucket_name                      = module.s3_artifacts_bucket.bucket
  build_projects                      = local.build_projects
  build_project_source                = var.build_project_source
  builder_compute_type                = var.builder_compute_type
  builder_image                       = var.builder_image
  builder_image_pull_credentials_type = var.builder_image_pull_credentials_type
  builder_type                        = var.builder_type
  kms_key_arn                         = module.codepipeline_kms.arn
  vpc_name                            = local.vpc_name
  vpc_enabled                         = local.vpc_enabled
  tags = {
    Project_Name = local.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }
}

module "codepipeline_kms" {
  source                = "../../modules/kms"
  codepipeline_role_arn = module.codepipeline_iam_role.role_arn
  tags = {
    Project_Name = local.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }

}

module "codepipeline_iam_role" {
  source                     = "../../modules/iam-role"
  project_name               = local.project_name
  create_new_role            = local.create_new_role
  codepipeline_iam_role_name = local.create_new_role == true ? "${local.project_name}-codepipeline-role" : local.codepipeline_iam_role_name
  source_repository_name     = local.source_repo_name
  kms_key_arn                = module.codepipeline_kms.arn
  s3_bucket_arn              = module.s3_artifacts_bucket.arn
  tags = {
    Project_Name = local.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }
}
# Module for Infrastructure Validate, Plan, Apply and Destroy - CodePipeline
module "codepipeline_terraform" {
  depends_on = [
    module.codebuild_terraform,
    module.s3_artifacts_bucket
  ]
  source = "../../modules/codepipeline"

  project_name          = local.project_name
  source_repo_name      = local.source_repo_name
  source_repo_branch    = local.source_repo_branch
  s3_bucket_name        = module.s3_artifacts_bucket.bucket
  codepipeline_role_arn = module.codepipeline_iam_role.role_arn
  stages                = local.stage_input
  kms_key_arn           = module.codepipeline_kms.arn
  tags = {
    Project_Name = local.project_name
    Environment  = var.environment
    Account_ID   = local.account_id
    Region       = local.region
  }
}
