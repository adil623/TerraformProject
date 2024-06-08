# Security group for public instances - allows inbound SSH access
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public instances to allow SSH"
  vpc_id      = module.networking.vpc_id

  # Allow inbound SSH from anywhere - consider restricting to known IPs
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public SSH Access"
  }
}

# Security group for private instances - allow SSH within the VPC
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private instances, SSH within VPC"
  vpc_id      = module.networking.vpc_id

  # Allow inbound SSH from the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.networking.vpc_cidr] # Assuming this output exists in networking module
  }

  # Allow inbound HTTP from the load balancer security group
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id] # Reference to the load balancer security group
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Private Instance Security Group"
  }
}
