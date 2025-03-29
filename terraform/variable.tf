variable "location" {
  description = "The Azure region to deploy resources"
  default     = "East US"
}

variable "jwt_secret" {
  type      = string
  sensitive = true
}

variable "resend_api" {
  type      = string
  sensitive = true
}

variable "firebase_creds" {
  type      = string
  sensitive = true
}