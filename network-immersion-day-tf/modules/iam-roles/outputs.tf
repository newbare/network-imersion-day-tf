# modules/iam-roles/outputs.tf

output "instance_profile_name" {
  description = "Nome do instance profile para usar nas EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "role_arn" {
  description = "ARN da IAM Role"
  value       = aws_iam_role.ec2_role.arn
}

output "role_name" {
  description = "Nome da IAM Role"
  value       = aws_iam_role.ec2_role.name
}
