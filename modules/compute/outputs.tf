output "app_security_group_id" {
  description = "Application security group ID"
  value       = aws_security_group.app.id
}

output "launch_template_id" {
  description = "Launch template ID"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_name" {
  description = "Auto Scaling Group name"
  value       = aws_autoscaling_group.this.name
}
