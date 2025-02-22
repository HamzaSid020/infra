# Azure Local Setup

## Prerequisites
- **Visual Studio Code (VS Code)** installed
- **Azure Subscription**
- **Terraform** installed
- **Git** installed and configured

## Step 1: Install Azure Tools Extension
1. Open **VS Code**.
2. Go to the **Extensions Marketplace** (`Ctrl+Shift+X`).
3. Search for **"Azure Tools"** and install the extension.
4. This extension includes:
   - Azure Account
   - Azure App Service
   - Azure Functions
   - Azure Storage
   - Other Azure-related tools

## Step 2: Authenticate with Azure
1. Open **Azure Explorer** (`Ctrl+Shift+A`).
2. Click **Sign in to Azure**.
3. Authenticate via the browser window.
4. Once signed in, Azure subscriptions and resources appear in **Azure Explorer**.

---

## Terraform Infrastructure Setup
This Terraform configuration provisions Azure resources.

### **📁 Project Structure**
```
📦 Terraform Project
├── main.tf       # Defines resource group, VM, and identity
├── network.tf    # Configures Virtual Network (VNet), Subnets, and NSG rules
├── outputs.tf    # Outputs relevant Terraform-created resources
```

### **Terraform Workflow**
1. Clone the repository:  
   ```sh
   git clone <repository-url>
   cd infra
   ```
2. Navigate to the Terraform directory:  
   ```sh
   cd terraform
   ```
3. Initialize Terraform:  
   ```sh
   terraform init
   ```
4. Validate configuration:  
   ```sh
   terraform validate
   ```
5. Plan deployment:  
   ```sh
   terraform plan
   ```
6. Apply configuration:  
   ```sh
   terraform apply -auto-approve
   ```
7. Verify deployed resources:  
   ```sh
   terraform output
   ```

---
### ✅ Azure environment successfully set up!



## Architecture Diagram in Progress:

![image](https://github.com/user-attachments/assets/3116346e-6ec6-4c35-bd7e-13033b6bce77)


