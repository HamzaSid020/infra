variable "resource_group_name" {
  default     = "microservice-rg"
  description = "Name of the resource group"
}

variable "location" {
  default     = "East US"
  description = "Azure region for deployment"
}

variable "acr_name" {
  default     = "microserviceacr123"
  description = "Unique name for Azure Container Registry"
}

variable "aks_cluster_name" {
  default     = "microservice-aks"
  description = "Name of your AKS cluster"
}

variable "dns_prefix" {
  default     = "microserviceaks"
  description = "DNS prefix for the AKS cluster"
}

variable "node_count" {
  default     = 3
  description = "Number of nodes in AKS cluster"
}

variable "vm_size" {
  default     = "Standard_DS2_v2"
  description = "VM size for AKS nodes"
}
