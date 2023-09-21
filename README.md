# EKS Multi-Tenancy Terraform Solution

This repository contains the terraform modules to deploy infrastructure for EKS multi-tenancy.

### Directory Strucutre
```bash
.
├── bootstrap
├── demo
│   ├── compute
│   │   └── k8s
│   │       └── cfg-tenant-mgmt
│   │           ├── charts
│   │           └── templates
│   ├── network
│   └── pipeline
├── modules
│   ├── codebuild
│   ├── codecommit
│   ├── codepipeline
│   ├── iam-role
│   ├── kms
│   ├── s3
│   ├── transit_gw
│   └── vpc
└── templates
    └── scripts
```

### Bootstrap Backend S3 and DynamoDB

To store the terraform state in s3 bucket and lock the state usig dynamodb, we have to create a s3 bucket and dynamodb table.

Go to bootstrap directory, update the main.tf with the bucket name and dynamodb table name that you want and run below commands

```bash
terraform init
terraform plan 
terraform apply
```

### Deployment Order

Modules have to be deployed in the below order. Please note that Pipeline module has to be built by running terraform commands manually.

- Pipeline
- Network
- Compute

### Deployment Instructions

Use the run.sh script in the root directory to deploy any module to any environment.Please note that only pipeline module should be built using the script with below arguments. The network and compute modules would be built through codepipeline.

```bash
./run.sh -m pipeline -env demo -region us-west-2 -tfcmd init
./run.sh -m pipeline -env demo -region us-west-2 -tfcmd plan
./run.sh -m pipeline -env demo -region us-west-2 -tfcmd apply
```