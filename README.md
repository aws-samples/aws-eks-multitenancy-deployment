
# EKS Multi-Tenancy Terraform Solution

This repository contains the Terraform modules to deploy infrastructure for EKS multi-tenancy.

## Description

This project simplifies infrastructure provisioning for AWS EKS multi-tenancy using Terraform and AWS DevOps services.

## Skills Required

- AWS DevOps
- Terraform

## Directory Structure

```
.
├── bootstrap
├── demo
│   ├── compute
│   │   └── k8s
│   │       └── cfg-tenant-mgmt
│   │           └── templates
│   ├── network
│   └── pipeline
├── modules
│   ├── codebuild
│   ├── codecommit
│   ├── codepipeline
│   ├── gitops
│   ├── iam-role
│   ├── kms
│   ├── s3
│   ├── transit_gw
│   └── vpc
└── templates
    └── scripts
```

## Bootstrap Backend S3 and DynamoDB

To store the Terraform state in an S3 bucket and lock the state using DynamoDB, use the provided script in the `bootstrap` directory. This script creates the necessary S3 bucket and DynamoDB table. Run the following command from the `bootstrap` directory:

```sh
./bootstrap.sh
```

## Deployment Order

Modules must be deployed in the order listed below. Note that the Pipeline module should be built by running Terraform commands manually:

- Pipeline
- Network
- Compute

## Deployment Instructions

Use the `run.sh` script in the root directory to deploy any module to any environment. Remember, only the pipeline module should be built using the script with the arguments below. The network and compute modules will be built through CodePipeline.

```
./run.sh -m pipeline -env demo -region us-west-2 -tfcmd init
./run.sh -m pipeline -env demo -region us-west-2 -tfcmd plan
./run.sh -m pipeline -env demo -region us-west-2 -tfcmd apply
```

## Additional Instructions:
Once the CodePipeline successfully deploys, you will have the following AWS resources created:

- Egress VPC with 3 Public & 3 Private Subnets with IGW and NAT Gateway
- EKS VPC with 3 Private Subnets
- Tenant 1 and Tenant 2 VPC with 3 Private Subnets each
- Transit Gateway with all VPC attachments and routes to each private subnet
- Stages in CodePipeline

## The CodePipeline consists of these stages:
- Stage-validate: Initializes Terraform, runs security scans using checkov and tfsec tools, and uploads scan reports to the S3 bucket.
- Stage-plan: Displays the Terraform plan and uploads the plan to the S3 bucket.
- Stage-apply: Applies the Terraform plan output from the S3 and establishes AWS services.
- Stage-destroy: A manual step used to remove all AWS services previously created. (This stage is not enabled by default, if need to create destroy stage in CodePipeline, update `enable_destroy_stage` to true)

## Troubleshooting

### Issue: Failed to checkout and determine revision

If you encounter an error message similar to the one below:

```
  Failed to checkout and determine revision: unable to clone
  unknown error: You have successfully authenticated over SSH. You can use Git to interact with AWS CodeCommit.
```

Follow the troubleshooting steps below:

1. **Verify Tenant Application Repository**: Ensure that the tenant application repository contains the required code. It's possible that an empty or misconfigured repository is leading to the error.

2. **Redeploy the tenant_mgmt Module**:
   
   - Open the `tenant_mgmt` module configuration and locate the `app` block.
   
   - Update the `deploy` parameter value to `0`:
     ```hcl
     deploy = 0
     ```
   - Once the above apply completes, change the `deploy` parameter value back to `1`:
     ```hcl
     deploy = 1
     ```

3. **Recheck the Status**: After executing the above steps, use the `kubectl get gitrepositories -A` command to check if the issue persists. If it does, consider diving deeper into the Flux logs for more details or refer back to the general troubleshooting guide.



Contributors:
1. Aditya Ambati
2. Aniket Dekate
3. Nadeem Rahaman

