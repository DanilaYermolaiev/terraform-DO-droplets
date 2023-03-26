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

# provided by the GitLab CI template
variable "environment_slug" {
  description = "Environment FQDN"
  type = string
  default = "terralab"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t3.micro"
}

variable "ssh_pub_key_file" {
  description = "SSH public key file"
  type = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOWDHuzNbTpxrGtGS4dhTqRctyWOgDuuPjKjmBk14nf+"
  sensitive = true
}

variable "ssh_user_name" {
  description = "SSH username"
  type = string
  default = "ec2-user"
}

# variable "config_files" {
#   type = string
#   description = "AWS access key"
# }

# variable "credentials_files" {
#   type = string
#   description = "AWS secret key"
# }

variable "aws_region" {
  type = string
  description = "AWS region"
  default = "eu-north-1"
}