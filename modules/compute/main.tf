resource "aws_instance" "ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  user_data              = var.user_data
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_pair_name # Attach the key pair to the instance
  tags                   = var.tags
}
