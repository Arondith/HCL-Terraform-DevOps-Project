# CloudForge — Terraform AWS DevOps Portfolio

**CloudForge** is a reusable infrastructure-as-code project built with **Terraform / HCL**. It models a container-ready AWS platform with networking, ECS Fargate, load balancing, logging, autoscaling, environment profiles, automated tests, and CI.

The repository is designed to demonstrate Terraform engineering without requiring CI to create cloud resources.

## What this project demonstrates

- Terraform / HCL
- reusable Terraform modules
- AWS provider
- VPC design
- multi-AZ subnetting
- public and private networking
- Internet Gateway
- optional NAT Gateway
- ECS Fargate
- Application Load Balancer
- security groups
- IAM roles
- CloudWatch Logs
- ECS deployment rollback
- Application Auto Scaling
- input validation
- Terraform `check` blocks
- environment-specific tfvars
- mocked `terraform test`
- TFLint
- GitHub Actions CI
- remote-state design documentation
- cost-aware infrastructure choices

## Architecture

```text
Internet
   |
Application Load Balancer
   |
ECS Fargate Service
   |
CloudWatch Logs + Auto Scaling

VPC
├── Public subnet A
├── Public subnet B
├── Private subnet A
└── Private subnet B
```

The production example places ECS tasks in private subnets with NAT egress. The development profile can avoid NAT costs by placing tasks in public subnets with assigned public IPs.

## Repository structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
├── backend.hcl.example
├── env/
│   ├── dev.tfvars
│   └── prod.tfvars
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ecs_service/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── tests/
│   └── platform.tftest.hcl
└── docs/
    └── ARCHITECTURE.md
```

## Prerequisites

For validation and mocked tests:

- Terraform 1.8+
- internet access for provider installation

For real deployment:

- AWS account
- AWS credentials configured outside the repository
- appropriate IAM permissions

## Validate locally

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
terraform test
```

Run TFLint if installed:

```bash
tflint --init
tflint --recursive
```

## Inspect the development plan

With AWS credentials configured:

```bash
terraform init
terraform plan -var-file=env/dev.tfvars
```

## Inspect the production example

```bash
terraform plan -var-file=env/prod.tfvars
```

## Apply

This repository deliberately does **not** auto-apply infrastructure in CI.

If you intentionally want to deploy it:

```bash
terraform apply -var-file=env/dev.tfvars
```

Review the plan and AWS pricing before approving an apply. NAT Gateways, load balancers, Fargate tasks, CloudWatch Logs, and data transfer may incur charges.

## Environment differences

| Setting | Dev | Production example |
| --- | --- | --- |
| Availability zones | 2 | 2 |
| NAT Gateway | Disabled | Enabled |
| ECS task networking | Public IP | Private + NAT |
| Desired tasks | 1 | 2 |
| Autoscaling max | 2 | 6 |
| Log retention | 7 days | 30 days |

## Terraform tests

`tests/platform.tftest.hcl` uses Terraform's mocked provider support.

The tests verify that:

- the dev profile plans successfully;
- the dev profile keeps NAT disabled;
- the dev profile selects public-IP task networking;
- the production profile plans successfully;
- the production profile enables NAT;
- the production profile selects private task networking.

No real AWS credentials are needed for these tests.

## CI

Every push and pull request runs:

- Terraform formatting checks
- provider initialization
- Terraform validation
- mocked Terraform tests
- TFLint

The workflow never executes `terraform apply`.

## Remote state

The project keeps backend configuration out of the main Terraform configuration so the repo remains portable.

A real environment can initialize remote state with a configuration based on:

```text
backend.hcl.example
```

For a production implementation, use a dedicated state bucket with encryption, versioning, restricted IAM access, and state locking.

## Security notes

The current listener uses HTTP for a self-contained portfolio example. A production deployment should normally add ACM, HTTPS, HTTP-to-HTTPS redirection, DNS, and potentially WAF.

The ECS task security group accepts application traffic only from the ALB security group.

Secrets and AWS credentials must never be committed to this repository.

## Portfolio value

CloudForge demonstrates infrastructure skills relevant to:

- DevOps Engineer
- Cloud Engineer
- Platform Engineer
- Infrastructure Engineer
- Site Reliability Engineer
- Systems Engineer
- Backend/Software Engineer roles involving cloud infrastructure

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for more design detail.
