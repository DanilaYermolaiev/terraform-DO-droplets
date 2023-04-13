###################################
## Virtual Machine Module - Main ##
###################################

# Create Elastic IP for the EC2 instance
resource "aws_eip" "linux-eip" {
  vpc = true
  tags = {
    Name = "${var.environment_slug}-${random_string.random.result}-linux-eip"

  }
}

resource "random_string" "random" {
  length  = 3
  upper   = false
  special = false
}

# Security Group
resource "aws_security_group" "webserver_sg" {
  name        = "${var.environment_slug}-${random_string.random.result}-webserver-sg"
  description = "WebServer DMZ"
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment_slug}-${random_string.random.result}-webserver-sg"
  }


  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Associate Elastic IP to Linux Server
resource "aws_eip_association" "linux-eip-association" {
  instance_id   = aws_instance.webserver.id
  allocation_id = aws_eip.linux-eip.id
}

# EC2 instance
resource "aws_instance" "webserver" {
  # Lookup the correct AMI based on the region we specified
  ami = lookup(var.aws_amis, var.aws_region)

  instance_type = var.instance_type
  user_data  = data.template_file.user_data.rendered
  key_name   = var.ssh_key_name
  monitoring = true

  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  associate_public_ip_address = var.linux_associate_public_ip_address
  source_dest_check           = false

  connection {
    type = "ssh"

    # The default username for our AMI
    user        = var.ssh_user_name
    key_name    = var.ssh_key_name

    # The connection will use the local SSH agent for authentication.
  }
  # root disk
  root_block_device {
    volume_size           = var.linux_root_volume_size
    volume_type           = var.linux_root_volume_type
    delete_on_termination = true
    encrypted             = true
  }
    #EBS Block Storage
  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_size           = var.ebs_volume_size
    volume_type           = var.ebs_volume_type
    delete_on_termination = false
  }
}

data "template_file" "user_data" {

  template = file(var.cloud_init_filepath)
}
# resource "aws_ec2_instance_state" "webserver" {
#   instance_id = aws_instance.webserver.id
#   state       = "stopped"
# }
