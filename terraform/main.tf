# Define required providers
terraform {
  # using GitLab http backend
  # see: https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html
  # backend "http" {
  #   # auto-configured by the template
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Enable the AWS Provider (configured by env variables)
provider "aws" {
}

# Security Group
resource "aws_security_group" "webserver_sg" {
  name = "${var.environment_slug}-webserver-sg"
  description = "WebServer DMZ"
  tags = {
    Name = "${var.environment_slug}-webserver-sg"
  }

  ingress {
    description = "HTTP (80)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH (22)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
data "aws_ami" "al2_latest" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "webserver" {
  ami                         = data.aws_ami.al2_latest.image_id
  instance_type               = var.instance_type
  # user_data                 = file("init-script.sh")
  key_name                    = aws_key_pair.ansible_keypair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [ aws_security_group.webserver_sg.id ]

  tags = {
    Name = "${var.environment_slug}-webserver"
  }
}

resource "aws_key_pair" "ansible_keypair" {
  key_name   = "${var.environment_slug}-ansible-key"
  public_key = file(var.ssh_pub_key_file)
}
