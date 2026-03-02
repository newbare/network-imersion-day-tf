output "vpc_a_id" {
  value = module.vpc_a.vpc_id
}

output "vpc_b_id" {
  value = module.vpc_b.vpc_id
}

output "vpc_c_id" {
  value = module.vpc_c.vpc_id
}

output "peering_ab_id" {
  value = module.vpc_peering_ab.peering_ids["ab"]
}

output "peering_ac_id" {
  value = module.vpc_peering_ac.peering_ids["ac"]
}
