variable "linux_root_volume_size" {
  type        = number
  description = "Volumen size of root volumen of Linux Server"
  default     = "30"
}

variable "linux_root_volume_type" {
  type        = string
  description = "Volumen type of root volumen of Linux Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "gp2"
}

variable "ebs_volume_size" {
  type        = number
  description = "Volumen size volumen of Linux Server"
  default     = "30"
}

variable "ebs_volume_type" {
  type        = string
  description = "Volumen type volumen of Linux Server. Can be standard, gp3, gp2, io1, sc1 or st1"
  default     = "standart"
}
# provided by the GitLab CI template
variable "environment_slug" {
  description = "Environment FQDN"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
  default     = "new"

variable "ssh_user_name" {
  description = "SSH username"
  type        = string
  default     = "ubuntu"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-north-1"
}

variable "linux_associate_public_ip_address" {
  type        = bool
  description = "Associate a public IP address to the EC2 instance"
  default     = true
}

# AWS AZ
variable "aws_az" {
  type        = string
  description = "AWS AZ"
  default     = "eu-north-1c"
}

# VPC Variables
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
  default     = "10.1.64.0/18"
}

# Subnet Variables
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for the public subnet"
  default     = "10.1.64.0/24"
}

variable "cloud_init_filepath" {
  type        = string
  description = "filepath to cloud-init script"
  default     = "./start-instance.yml"
}
# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-north-1c = "ami-064087b8d355e9051"
  }
}