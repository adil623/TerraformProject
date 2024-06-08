variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region to deploy resources"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-04b70fa74e45c3917"
}

variable "ARN_KeyPair" {
  description = "ARN for S3"
  default     = "arn:aws:s3:::ajkeyvaluepair/ad-keypair.pem"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ARN of the ACM certificate"
  default     = "arn:aws:acm:us-east-1:660731010466:certificate/b6349d3b-55e3-455f-a6d8-2c1103119d34"
}