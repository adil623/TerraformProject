provider "aws" {
  region = var.aws_region
}

module "networking" {
  source             = "./modules/networking"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


module "ec2_public" {
  source            = "./modules/compute"
  subnet_id         = module.networking.public_subnet_ids[0]
  ami_id            = var.ami_id # Example AMI ID
  user_data         = file("${path.module}/user_data/nginx_docker_nodejs.sh")
  security_group_id = aws_security_group.public_sg.id
  instance_name     = "Bastion"
  key_pair_name     = "ad-keypair"
  tags = {
    Name    = "Bastion"
    Service = "Bastion" // Example tag for identifying service type
  }
}

module "ec2_private_1" {
  source            = "./modules/compute"
  subnet_id         = module.networking.private_subnet_ids[0]
  ami_id            = var.ami_id # Example AMI ID
  user_data         = file("${path.module}/user_data/nginx_docker_nodejs.sh")
  security_group_id = aws_security_group.private_sg.id
  instance_name     = "frontend"
  key_pair_name     = "ad-keypair"
  tags = {
    Name    = "frontend"
    Service = "frontend" // Example tag for identifying service type
  }
}

module "ec2_private_2" {
  source            = "./modules/compute"
  subnet_id         = module.networking.private_subnet_ids[1]
  ami_id            = var.ami_id # Example AMI ID
  user_data         = file("${path.module}/user_data/nginx_docker_nodejs.sh")
  security_group_id = aws_security_group.private_sg.id
  instance_name     = "backend"
  key_pair_name     = "ad-keypair"
  tags = {
    Name    = "backend"
    Service = "backend" // Example tag for identifying service type
  }
}

module "ec2_private_3" {
  source            = "./modules/compute"
  subnet_id         = module.networking.private_subnet_ids[2]
  ami_id            = var.ami_id # Example AMI ID
  user_data         = file("${path.module}/user_data/nginx_docker_nodejs.sh")
  security_group_id = aws_security_group.private_sg.id
  instance_name     = "metabase"
  key_pair_name     = "ad-keypair"
  tags = {
    Name    = "metabase"
    Service = "metabase" // Example tag for identifying service type
  }
}

module "db_private" {
  source                  = "./modules/database"
  db_allocated_storage    = 10
  db_engine               = "mysql"
  db_engine_version       = "8.0"
  db_instance_class       = "db.t3.micro"
  db_name                 = "mydb"
  db_username             = "foo"
  db_password             = "foobarbaz"
  db_parameter_group_name = "default.mysql8.0"
  subnet_ids              = [module.networking.private_subnet_ids[1], module.networking.private_subnet_ids[2]]
  rds_security_group_id   = aws_security_group.rds_sg.id
  db_instance_tag_name    = "db"
}

module "load_balancer" {
  source = "./modules/load_balancer"

  # Assuming these variables are declared in the load balancer module
  public_subnet_ids    = module.networking.public_subnet_ids
  acm_certificate_arn  = var.acm_certificate_arn
  lb_security_group_id = aws_security_group.lb_sg.id
  vpc_id               = module.networking.vpc_id
  frontend_instance_id  = module.ec2_private_1.instance_id
  backend_instance_id   = module.ec2_private_2.instance_id
  metabase_instance_id  = module.ec2_private_3.instance_id
}
