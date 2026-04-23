variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "web_instance_type" {
  description = "Instance type for web servers"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_type" {
  description = "Instance type for database server"
  type        = string
  default     = "t3.small"
}

variable "key_pair_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "my_ip" {
  description = "Your current IP address in CIDR notation (e.g. 1.2.3.4/32)"
  type        = string
}

variable "admin_username" {
  description = "Username for password-based SSH access on private servers"
  type        = string
  default     = "techadmin"
}

variable "admin_password" {
  description = "Password for password-based SSH access on private servers"
  type        = string
  sensitive   = true
}
