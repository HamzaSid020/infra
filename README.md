# Azure Local Setup

## Prerequisites
- **VS Code** installed
- **Azure Subscription**
- **Terraform** installed

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

## Step 2: Sign In to Azure
1. Open the **Azure Explorer** (`Ctrl+Shift+A`).
2. Click **Sign in to Azure**.
3. Authenticate via the browser window.
4. After signing in, Azure subscriptions and resources appear in the **Azure Explorer**.

---

## Terraform Infrastructure Setup
This Terraform configuration provisions Azure resources.

### **📁 Project Structure**
```
📦 Terraform Project
├── main.tf       # Defines resource group, VM, and identity
├── network.tf    # Configures VNet, Subnets, and NSG rules
├── outputs.tf    # Outputs relevant Terraform-created resources
```

### **Terraform Commands**
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
4. Plan changes:  
   ```sh
   terraform plan
   ```
5. Apply changes:  
   ```sh
   terraform apply -auto-approve
   ```






## Architecture Diagram in Progress:

![image](https://github.com/user-attachments/assets/3116346e-6ec6-4c35-bd7e-13033b6bce77)
