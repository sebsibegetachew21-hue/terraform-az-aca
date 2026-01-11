variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "eastus"
}

variable "name_prefix" {
  description = "Prefix used for resource names"
  type        = string
  default     = "tf-aca"
}

variable "container_image" {
  description = "Public container image to run (start simple: public image, no ACR needed)"
  type        = string
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "target_port" {
  description = "Port your container listens on"
  type        = number
  default     = 80
}

variable "acr_name" {
  description = "Globally unique ACR name (5-50 chars, lowercase alphanumeric only)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{5,50}$", var.acr_name))
    error_message = "acr_name must be 5-50 characters and contain only lowercase letters and numbers."
  }
}
