#Output for VPC
output "vpc_id" {
  description = "Dev VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Dev public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Dev private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_ids" {
  description = "Dev NAT gateway IDs"
  value       = module.vpc.nat_gateway_ids
}

#Output for Compute

output "app_security_group_id" {
  description = "Application security group ID"
  value       = module.compute.app_security_group_id
}

output "launch_template_id" {
  description = "Launch template ID"
  value       = module.compute.launch_template_id
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = module.compute.autoscaling_group_name
}


#Output for Database

output "db_instance_identifier" {
  description = "Database instance identifier"
  value       = module.database.db_instance_identifier
}

output "db_endpoint" {
  description = "Database endpoint"
  value       = module.database.db_endpoint
}

output "db_port" {
  description = "Database port"
  value       = module.database.db_port
}

output "db_security_group_id" {
  description = "Database security group ID"
  value       = module.database.db_security_group_id
}
