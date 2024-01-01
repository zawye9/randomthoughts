provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "ap-southeast-1"
}
resource "aws_vpc" "laravel" {
    cidr_block = "10.1.0.0/16"
    tags = {
        Environment = "dev"
        Name = "laravel"
    }
  
}
resource "aws_subnet" "laravel-subnet" {
    vpc_id = aws_vpc.laravel.id
    cidr_block = "10.1.1.0/24"
  
}
resource "aws_security_group" "laravel-sg" {
  name = "Allow-all"
  vpc_id = aws_vpc.laravel.id
  ingress {
    description = "allow MSSQL Specific IP"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_network_interface" "laravel-eni" {
    subnet_id = aws_subnet.laravel-subnet.id
    
}
resource "aws_instance" "laravel-ec2" {
    ami = "ami-0fa377108253bf620"
    instance_type = "t2.micro"
    network_interface {
      network_interface_id = aws_network_interface.laravel-eni.id
      device_index = 0
    }
    tags = {
      "Name" = "public_laravel" 
    }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.laravel.id
  
}
resource "aws_eip" "laravel_ip" {
  instance = aws_instance.laravel-ec2.id
  domain = "vpc"
  
}