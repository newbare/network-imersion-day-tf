# Outputs do laboratório 02-multiple-vpcs

output "vpc_a_id" {
  value = module.vpc_a.vpc_id
}

output "vpc_b_id" {
  value = module.vpc_b.vpc_id
}

output "vpc_c_id" {
  value = module.vpc_c.vpc_id
}

output "vpc_a_tgw_subnet_ids" {
  value = module.vpc_a.tgw_subnet_ids
}

output "vpc_b_tgw_subnet_ids" {
  value = module.vpc_b.tgw_subnet_ids
}

output "vpc_c_tgw_subnet_ids" {
  value = module.vpc_c.tgw_subnet_ids
}
