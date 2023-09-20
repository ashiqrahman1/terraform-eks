terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

data "aws_vpc" "main" {
  default = true
} 

data "aws_ssm_parameter" "my-amzn-linux-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "instance" {
  ami           = data.aws_ssm_parameter.my-amzn-linux-ami.value
  instance_type = var.instance_type
  tags = {
    "my_instance" = "terraform"
  }
  tags_all = {
    "my_instance" = "terraform"
  }
  user_data = file("${path.module}/userdata.sh")
  vpc_security_group_ids = [aws_security_group.webSG.id]
}

resource "aws_security_group" "webSG" {
  name = "webSG"
  description = "Allow port 22 and 80"
  vpc_id = data.aws_vpc.main.id

  egress {
    from_port =  0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sshsg" {
  type = "ingress"
  from_port = var.ssh_sg
  to_port = var.ssh_sg
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webSG.id
}

resource "aws_security_group_rule" "httpsg" {
  type = "ingress"
  from_port = var.http_sg
  to_port = var.http_sg
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.webSG.id
}