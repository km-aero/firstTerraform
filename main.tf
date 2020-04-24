provider "aws" {
  region = "eu-west-1"
}

# create a VPC
# resource "aws_vpc" "app_vpc" {
#  cidr_block = "10.0.0.0/16"
#
#  tags = {
#    Name = "kevin-eng54-app-vpc"
#  }
# }

# create subnet inside devops vpc
resource "aws_subnet" "app-subnet" {
  vpc_id = "vpc-07e47e9d90d2076da"
  cidr_block = "172.31.96.0/24"
  availability_zone = "eu-west-1b"
}

# move instance into subnet
# launch ec2
resource "aws_instance" "app_instance" {
  ami = "ami-0d20eb88a430fd0d8"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.app-subnet.id
  security_groups = [aws_security_group.home_access.id]

  tags = {
    Name = "kevin-eng54-app"
  }
}

resource "aws_security_group" "home_access" {
  name = "home-access"
  description = "allows home access to instance"
  vpc_id = "vpc-07e47e9d90d2076da"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =["90.211.38.46/32"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kevin-home-access-again"
  }
}
