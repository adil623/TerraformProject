variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be deployed"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the Load Balancer"
}

variable "lb_security_group_id" {
  type        = string
  description = "Security Group ID for the Load Balancer"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate"
}

variable "frontend_instance_id" {
  type = string
}

variable "backend_instance_id" {
  type = string
}

variable "metabase_instance_id" {
  type = string
}
