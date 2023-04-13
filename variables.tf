variable "public_key_path" {
  default = "new.pub"
}

variable "private_key_path" {
  default = "new.pem"
}

variable "key_name" {
  default     = "new"
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-1 = "ami-064087b8d355e9051"
  }
}
variable "cloud_init_filepath" {
  type        = string
  description = "filepath to cloud-init script"
  default     = "./start-instance.yml"
}