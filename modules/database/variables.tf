variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgresql)"
  type        = string
}

variable "db_engine_version" {
  description = "The version of the database engine to use"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the database at initial creation"
  type        = string
}

variable "db_username" {
  description = "Username for the database administrator"
  type        = string
}

variable "db_password" {
  description = "Password for the database administrator"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "The ID of the VPC subnet the RDS instance should be placed in"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "The ID of the security group to associate with the RDS instance"
  type        = string
}

variable "db_deletion_protection" {
  description = "Indicates if the DB instance should have deletion protection enabled"
  type        = bool
  default     = false
}

variable "db_instance_tag_name" {
  description = "The value of the 'Name' tag assigned to the RDS instance"
  type        = string
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is a multi-AZ deployment"
  type        = bool
  default     = false
}

variable "db_parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}

variable "db_option_group_name" {
  description = "The name of the option group to be used for the RDS instance"
  type        = string
  default     = null
}

variable "db_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "db_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  type        = string
  default     = "gp2"
}
