# Security Policy

CloudForge is an infrastructure-as-code portfolio project.

## Credentials

Never commit AWS access keys, secret keys, session tokens, private keys, Terraform state files, or production secrets.

Use environment variables, AWS profiles, workload identity, or another approved credential mechanism.

## Applying infrastructure

The repository CI intentionally never runs `terraform apply`.

Before manually applying:

- review the Terraform plan;
- verify the target AWS account and region;
- review expected costs;
- use least-privilege IAM permissions;
- configure a secure remote backend for shared environments.

## Production hardening

The included platform is a portfolio reference implementation. Before production use, consider HTTPS/ACM, WAF, VPC endpoints, secret management, remote-state controls, centralized logging, and organization-specific security policies.
