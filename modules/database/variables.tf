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
  description = "VPC ID where the database will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the DB subnet group"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "At least two private subnet IDs are required."
  }
}

variable "app_security_group_id" {
  description = "Application security group ID allowed to connect to the database"
  type        = string
}

variable "db_engine" {
  description = "Database engine"
  type        = string

  validation {
    condition     = contains(["postgres", "mysql"], var.db_engine)
    error_message = "db_engine must be postgres or mysql."
  }
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number

  validation {
    condition     = var.db_allocated_storage >= 20
    error_message = "db_allocated_storage must be at least 20 GB."
  }
}

variable "db_name" {
  description = "Initial database name"
  type        = string

  validation {
    condition     = length(var.db_name) >= 1
    error_message = "db_name must not be empty."
  }
}

variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_username) >= 3
    error_message = "db_username must be at least 3 characters."
  }
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.db_password) >= 8
    error_message = "db_password must be at least 8 characters."
  }
}

variable "db_port" {
  description = "Database port"
  type        = number

  validation {
    condition     = var.db_port > 0 && var.db_port < 65536
    error_message = "db_port must be between 1 and 65535."
  }
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number

  validation {
    condition     = var.backup_retention_period >= 0 && var.backup_retention_period <= 35
    error_message = "backup_retention_period must be between 0 and 35."
  }
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
}

variable "tags" {
  description = "Common tags applied to database resources"
  type        = map(string)
  default     = {}
}
