# outputs.tf at the root of your Terraform project

output "vpc_id" {
  value       = module.networking.vpc_id
  description = "The ID of the VPC created in the networking module"
}

output "public_subnet_ids" {
  value       = module.networking.public_subnet_ids
  description = "The IDs of the public subnets created in the networking module"
}

output "private_subnet_ids" {
  value       = module.networking.private_subnet_ids
  description = "The IDs of the private subnets created in the networking module"
}

output "vpc_cidr" {
  value = module.networking.vpc_cidr
}

output "lb_dns_name" {
  value       = module.load_balancer.lb_dns_name
  description = "The DNS name of the load balancer"
}

# Reference outputs from EC2 modules
output "frontend_instance_id" {
  value = module.ec2_private_1.instance_id
}

output "backend_instance_id" {
  value = module.ec2_private_2.instance_id
}

output "metabase_instance_id" {
  value = module.ec2_private_3.instance_id
}
