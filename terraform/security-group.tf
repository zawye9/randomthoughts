provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region     = "ap-southeast-1"
}

resource "aws_security_group" "test" {
  name = "MSSQL Allow Rule"
  vpc_id = "vpc-074b861421f7bc16f"
  ingress {
    description = "allow MSSQL Specific IP"
    from_port = port_no
    to_port = port_no
    protocol = "tcp"
    cidr_blocks = var.cidr
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id = aws_security_group.test.id
  network_interface_id = "eni-id"
}

resource "aws_security_group" "test1" {
  name = "MSSQL Allow Rule-1"
  vpc_id = "vpc-id"
  ingress {
    description = "allow MSSQL Specific IP"
    from_port = port_no
    to_port = porn_no
    protocol = "tcp"
    cidr_blocks = var.cidr1
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_network_interface_sg_attachment" "sg_attachment-1" {
  security_group_id = aws_security_group.test1.id
  network_interface_id = "eni-id"
}
