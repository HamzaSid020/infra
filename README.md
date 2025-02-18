# Setting up Azure in Local

## Steps Followed

### Step 1: Install Azure Tools Extension
1. Open **VS Code**.
2. Go to the **Extensions Marketplace** (`Ctrl+Shift+X`).
3. Search for **"Azure Tools"** and install the extension.
4. The extension includes:
   - Azure Account
   - Azure App Service
   - Azure Functions
   - Azure Storage
   - And other Azure-related tools.

---

### Step 2: Sign In to Azure
1. Open the **Azure Explorer** by clicking the Azure icon in the Activity Bar or pressing `Ctrl+Shift+A`.
2. Click **Sign in to Azure**.
3. A browser window will open, prompting you to sign in with your Azure credentials.
4. After signing in, your Azure subscriptions and resources will appear in the Azure Explorer.

---

## Terraform Infrastructure Setup
The Terraform configuration defines the cloud infrastructure for our project in Azure. The structure includes:

### **📁 File Structure**
```
📦 Terraform Project
├── main.tf       # Defines resource group, VM, and identity
├── network.tf    # Configures VNet, Subnets, and NSG rules
├── outputs.tf    # Outputs relevant Terraform-created resources
```

### **Terraform Commands**
To initialize, validate, and apply the Terraform configuration, use the following commands:

```bash
# Initialize Terraform
terraform init

# Format Terraform files (optional but recommended)
terraform fmt

# Validate Terraform configuration
terraform validate

# Show the execution plan
terraform plan

# Apply the Terraform configuration
terraform apply -auto-approve

# Destroy resources (if needed)
terraform destroy -auto-approve
```

---

## **Next Steps**
- Install dependencies on the Azure VM using **Ansible**.
- Configure **Docker, Node.js, Python, and Kubernetes**.
- Automate deployment of microservices using **Terraform & Kubernetes (AKS)**.

---



















===========================================================================================================
# Infrastructure Repository Planned

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




## Architecture Diagram in Progress:
![image](https://github.com/user-attachments/assets/44c57686-2ca6-4081-aa01-bf145dad11fb)

