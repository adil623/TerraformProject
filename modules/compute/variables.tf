variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be deployed"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-04b70fa74e45c3917"
}

variable "user_data" {
  description = "User data script to run on instance initialization"
  default     = ""
}

variable "security_group_id" {
  description = "ID of the security group to associate with the EC2 instance"
}

variable "instance_name" {
  description = "Number of instances to create"
}

variable "key_pair_name" {
  description = "The name of the key pair to attach to the EC2 instances"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}


