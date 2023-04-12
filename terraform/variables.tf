# provided by the GitLab CI template
variable "environment_type" {
  description = "Environment Type"
  type = string
  default = "dev"
}

# provided by the GitLab CI template
variable "environment_name" {
  description = "Environment Name"
  type = string
  default = "dev"
}

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

# provided by the GitLab CI template
variable "environment_slug" {
  description = "Environment FQDN"
  type = string
  default = "dev"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.micro"
}

variable "ssh_pub_key_file" {
  description = "SSH public key file"
  type        = string
  default = "~/.ssh/id_ed25519.pub"
}

variable "ssh_user_name" {
  description = "SSH username"
  type = string
  default = "ubuntu"
}

variable "aws_region" {
  type = string
  description = "AWS region"
  default = "eu-north-1"
}