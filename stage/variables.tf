variable "aws_region" {
  description = "AWS region for the stage environment"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the VPC subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for compute resources"
  type        = string
}

variable "instance_type" {
  description = "Instance type for compute resources"
  type        = string
}

variable "app_port" {
  description = "Application port"
  type        = number
}

variable "allowed_ingress_cidrs" {
  description = "Allowed ingress CIDRs for the application"
  type        = list(string)
}

variable "ssh_cidr_blocks" {
  description = "Allowed CIDRs for SSH"
  type        = list(string)
}

variable "key_name" {
  description = "Optional EC2 key pair name"
  type        = string
  default     = null
}

variable "desired_capacity" {
  description = "Desired capacity for the Auto Scaling Group"
  type        = number
}

variable "min_size" {
  description = "Minimum size for the Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "Maximum size for the Auto Scaling Group"
  type        = number
}

variable "db_engine" {
  description = "RDS engine"
  type        = string
}

variable "db_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Database port"
  type        = number
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

variable "multi_az" {
  description = "Enable Multi-AZ for RDS"
  type        = bool
}

variable "deletion_protection" {
  description = "Enable deletion protection for RDS"
  type        = bool
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}
