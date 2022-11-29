# Input variable definitions

variable "vm_name" {
  description = "Name of the virtual machine (domain). Must be unique in pool."
  type        = string
}

variable "vm_memory" {
  description = "Memory allocation of the VM."
  type        = number
  default     = 512
}

variable "vm_cpu" {
  description = "CPU allocation of the VM."
  type        = number
  default     = 1
}

variable "base_image_id" {
  description = "ID of the base image to be used."
  type        = string
}

variable "pool_name" {
  description = "Libvirt pool for domain"
  type        = string
  default     = "default"
}

variable "disk_size" {
  description = "Size of root disk of domain."
  type        = number
  default     = 10737418240 # 10gb
}

variable "network_name" {
  description = "Name of the network where interface for VM will be created."
  type        = string
}

variable "cloudinit_disk_id" {
  description = "ID of volume for cloudinit to be mounted."
  type        = string
}
