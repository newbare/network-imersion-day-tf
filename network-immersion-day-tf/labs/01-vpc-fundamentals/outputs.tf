# Outputs do laboratório 01-vpc-fundamentals

# labs/01-vpc-fundamentals/outputs.tf

output "vpc_id" {
  description = "ID da VPC criada"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "Bloco CIDR da VPC"
  value       = module.vpc.vpc_cidr
}
