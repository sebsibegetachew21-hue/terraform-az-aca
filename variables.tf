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
