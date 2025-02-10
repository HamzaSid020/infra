# Infrastructure Repository

This repository contains the Infrastructure as Code (IaC) for our project, using Terraform for resource provisioning and Kubernetes for container orchestration.

## Repository Structure

infra/
│── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│── k8s/
│   ├── auth-deployment.yaml
│   ├── product-deployment.yaml
│   ├── order-deployment.yaml
│   ├── api-gateway.yaml
│── .github/workflows/
│── README.md


## Terraform

The `terraform/` directory contains Terraform configurations for provisioning and managing cloud resources.

- `main.tf`: Main Terraform configuration file
- `variables.tf`: Input variables for the Terraform modules
- `outputs.tf`: Output values from the Terraform execution

## Kubernetes

The `k8s/` directory contains Kubernetes manifests for deploying our microservices.

- `auth-deployment.yaml`: Authentication service deployment
- `product-deployment.yaml`: Product service deployment
- `order-deployment.yaml`: Order service deployment
- `api-gateway.yaml`: API Gateway configuration

## GitHub Actions

The `.github/workflows/` directory contains CI/CD pipelines for automating infrastructure deployments.

## Usage

1. Clone this repository
2. Navigate to the `terraform/` directory
3. Initialize Terraform: `terraform init`
4. Plan your changes: `terraform plan`
5. Apply the changes: `terraform apply`

For Kubernetes deployments, use `kubectl apply -f k8s/`

## Best Practices

- Use modules to organize and reuse Terraform code
- Implement proper naming conventions and tagging for resources
- Separate core infrastructure from application-specific resources
- Use version control for all infrastructure changes
- Implement proper security measures, such as least privilege access

## Contributing

Please follow the contribution guidelines when making changes to this repository.
