variable "project_name" {
  description = "Project name used for naming resources"
  type        = string

  validation {
    condition     = length(var.project_name) >= 3
    error_message = "Project name must contain at least 3 characters."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "vpc_id" {
  description = "VPC ID where compute resources will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the Auto Scaling Group"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_ids) >= 2
    error_message = "At least two public subnet IDs are required."
  }
}

variable "private_subnet_ids" {
  description = "Private subnet IDs reserved for later internal compute placement"
  type        = list(string)
  default     = []
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string

  validation {
    condition     = can(regex("^ami-[a-z0-9]+$", var.ami_id))
    error_message = "ami_id must look like a valid AMI ID."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number

  validation {
    condition     = var.desired_capacity >= 1
    error_message = "desired_capacity must be at least 1."
  }
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number

  validation {
    condition     = var.min_size >= 1
    error_message = "min_size must be at least 1."
  }
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number

  validation {
    condition     = var.max_size >= var.min_size
    error_message = "max_size must be greater than or equal to min_size."
  }
}

variable "app_port" {
  description = "Application port exposed by the instances"
  type        = number

  validation {
    condition     = var.app_port > 0 && var.app_port < 65536
    error_message = "app_port must be between 1 and 65535."
  }
}

variable "allowed_ingress_cidrs" {
  description = "CIDR ranges allowed to access the application port"
  type        = list(string)
}

variable "ssh_cidr_blocks" {
  description = "CIDR ranges allowed to access SSH"
  type        = list(string)
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags applied to compute resources"
  type        = map(string)
  default     = {}
}
