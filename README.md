# Infrastructure Repository  

This repository contains the Infrastructure as Code (IaC) for our project, using **Terraform** for resource provisioning and **Kubernetes** for container orchestration.  

## Repository Structure  

```plaintext
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
```

## Terraform  

The `terraform/` directory contains Terraform configurations for provisioning and managing cloud resources.  

- **`main.tf`** – Main Terraform configuration file  
- **`variables.tf`** – Input variables for the Terraform modules  
- **`outputs.tf`** – Output values from the Terraform execution  

## Kubernetes  

The `k8s/` directory contains Kubernetes manifests for deploying our microservices.  

- **`auth-deployment.yaml`** – Authentication service deployment  
- **`product-deployment.yaml`** – Product service deployment  
- **`order-deployment.yaml`** – Order service deployment  
- **`api-gateway.yaml`** – API Gateway configuration  

## GitHub Actions  

The `.github/workflows/` directory contains CI/CD pipelines for automating infrastructure deployments.  

## Usage  

1. Clone this repository:  
   ```sh
   git clone <repository-url>
   cd infra
   ```
2. Navigate to the `terraform/` directory:  
   ```sh
   cd terraform
   ```
3. Initialize Terraform:  
   ```sh
   terraform init
   ```
4. Plan your changes:  
   ```sh
   terraform plan
   ```
5. Apply the changes:  
   ```sh
   terraform apply
   ```
6. Deploy Kubernetes manifests:  
   ```sh
   kubectl apply -f k8s/
   ```

## Best Practices  

- Use **Terraform modules** to organize and reuse code.  
- Implement **proper naming conventions and tagging** for resources.  
- Separate **core infrastructure** from **application-specific** resources.  
- Use **remote state** (e.g., S3 + DynamoDB for Terraform state locking).  
- Follow **least privilege access** principles for security.  
- Use **Git version control** for all infrastructure changes.  

## Contributing  

Please follow the contribution guidelines when making changes to this repository.
