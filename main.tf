# Specify the provider and access details
provider "aws" {
  region = var.aws_region
}

# Create a VPC to launch
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
}

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# Create a subnet to launch our instances into
resource "aws_subnet" "default" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "forwarder" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
}

# Our default security group to access the instances
resource "aws_security_group" "default" {
  name        = "terraform"
  vpc_id      = aws_vpc.default.id

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

data "template_file" "init" {
  template = file(var.cloud_init_filepath)

}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "demoinstance" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)
  connection {
    type = "ssh"

    # The default username for our AMI
    user        = "ubuntu"
    private_key = file(var.private_key_path)

    # The connection will use the local SSH agent for authentication.
  }

  user_data     = data.template_file.init.rendered
  instance_type = "t3.medium"

  # Lookup the correct AMI based on the region we specified
  ami = lookup(var.aws_amis, var.aws_region)


  # Root Block Storage
  root_block_device {
    volume_size = "30"
    volume_type = "standard"
  }

  #EBS Block Storage
  ebs_block_device {
    device_name           = "/dev/sdb"
    volume_size           = "30"
    volume_type           = "standard"
    delete_on_termination = false
  }

  # The name of our SSH keypair we created above.
  key_name = aws_key_pair.auth.id

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = aws_subnet.default.id
}
