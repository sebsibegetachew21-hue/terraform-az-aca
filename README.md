# Azure Container Apps (ACA) — simplest Terraform deploy

This project deploys:
- 1 Resource Group
- 1 Log Analytics Workspace (recommended for Container Apps)
- 1 Container Apps Environment
- 1 Public Container App ("hello") using a public image

## Prereqs
- Terraform installed (1.6+ recommended)
- Azure CLI installed
- An Azure subscription you can deploy into

## Login
```bash
az login
az account show
```

## Deploy
```bash
terraform init
terraform apply
```

After apply, Terraform prints the app URL.

## Destroy
```bash
terraform destroy
```

## Notes
- Region defaults to `eastus`. Change it in `terraform.tfvars` if you prefer.
- The Container App uses a public image so you don't need ACR to get started.
# terraform-az-aca
