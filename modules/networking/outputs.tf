# modules/networking/outputs.tf

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC created by this module"
}

output "public_subnet_ids" {
  value       = aws_subnet.public.*.id
  description = "List of IDs for public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private.*.id
  description = "List of IDs for private subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "ID of the Internet Gateway"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "ID of the NAT Gateway"
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "ID of the route table associated with public subnets"
}

output "private_route_table_id" {
  value       = aws_route_table.private.id
  description = "ID of the route table associated with private subnets"
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}
