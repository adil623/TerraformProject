output "lb_dns_name" {
  value       = aws_lb.public_lb.dns_name
  description = "The DNS name of the load balancer"
}
