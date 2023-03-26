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
  ami                         = data.aws_ami.ubuntu-linux-1804.id
  instance_type               = var.instance_type
  user_data                   = file("aws-user-data.sh")
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
# Get latest Ubuntu Linux Bionic Beaver 18.04 AMI
data "aws_ami" "ubuntu-linux-1804" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}