provider "aws" {
  region = var.aws_region
}

/* Internet Gateway */
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tb_vpc.id
}

/* VPC */
resource "aws_vpc" "tb_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tb_vpc"
  }
}

/* subnet */
resource "aws_subnet" "tb_vpc_subnet_1" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.tb_vpc.id

  tags = {
    Name = "tb_vpc_subnet_1"
  }

  availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "tb_vpc_subnet_2" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.tb_vpc.id

  tags = {
    Name = "tb_vpc_subnet_2"
  }

  availability_zone = "ap-northeast-1c"
}

/* バックエンド用のsecurity group */
resource "aws_security_group" "nestjs_sg" {
  name        = "${local.app_name}-sg"
  description = "security group for nestjs app"
  vpc_id      = aws_vpc.tb_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

