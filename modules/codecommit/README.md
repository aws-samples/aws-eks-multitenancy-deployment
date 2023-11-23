## Terraform Configuration

### Providers

| Provider | Version |
|---|---|


### Modules

| Module Name | Source | Version |
|---|---|---|


### Inputs

| Input Variable | Description |
|---|---|
| `codecommit_description` | `Code Commit description` |
| `repo_approvers_arn` | `ARN or ARN pattern for the IAM User/Role/Group etc that can be used for approving Pull Requests` |
| `kms_key_arn` | `Name of the project to be prefixed to create the s3 bucket` |
| `source_repository_name` | `Name of the Source CodeCommit repository used by the pipeline` |
| `tags` | `Tags to be attached to the source CodeCommit repository` |
| `source_repository_branch` | `Branch of the Source CodeCommit repository used in pipeline` |
| `create_new_repo` | `Flag for deciding if a new repository needs to be created` |

### Outputs

| Output Variable | Description |
|---|---|
| `arn` | `LList containing the arn of the CodeCommit repositories` |
| `clone_url_http` | `List containing the clone url of the CodeCommit repositories` |
| `repository_name` | `List containing the name of the CodeCommit repositories` |
