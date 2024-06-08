resource "aws_db_instance" "mydb" {
  allocated_storage      = var.db_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.mydbsubnet.name
  vpc_security_group_ids = [var.rds_security_group_id]
  skip_final_snapshot = true
  identifier = "db"

  tags = {
    Name = var.db_instance_tag_name
  }
}

resource "aws_db_subnet_group" "mydbsubnet" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids // Updated to use a single subnet ID

  tags = {
    Name = "My DB Subnet Group"
  }
}
