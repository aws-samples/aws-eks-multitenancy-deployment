locals {
  account_id                 = data.aws_caller_identity.current.account_id
  region                     = data.aws_region.current.name
  repo_approvers_arn         = "arn:aws:sts::${local.account_id}:assumed-role/CodeCommitReview/*" #Update ARN (IAM Role/User/Group) of Approval Members
  project_name               = "cfg-eks-mt"
  source_repo_name           = "cfg-terraform"
  source_repo_branch         = "main"
  create_new_repo            = false
  create_new_role            = true
  vpc_name                   = "demo-eks-vpc" # after network module is created copy this value from portal, this works when vpc_enabled is set to true
  vpc_enabled                = false          # Enable this to attach vpc subnets and security groups to code build projects
  codepipeline_iam_role_name = ""
  enable_destroy_stage       = false
  common_stages = [
    { name = "validate", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "ValidateOutput" },
    { name = "plan", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "ValidateOutput", output_artifacts = "PlanOutput" },
    { name = "apply", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "PlanOutput", output_artifacts = "ApplyOutput" }
  ]

  destroy_stage = [
    { name = "destroy", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "ApplyOutput", output_artifacts = "DestroyOutput" }
  ]

  stage_input    = local.enable_destroy_stage ? concat(local.common_stages, local.destroy_stage) : local.common_stages
  build_projects = local.enable_destroy_stage ? ["validate", "plan", "apply", "destroy"] : ["validate", "plan", "apply"]
}
