# ssh_key
resource "aws_key_pair" "pro_key" {
  key_name = "pro-tf-key"
  public_key = file("../../.ssh/id_rsa.pub")
}

# main
provider "aws" {
  region = "ap-northeast-2"
}

# vpc
resource "aws_vpc" "pro_vpc" {
  cidr_block = "172.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = {
    "Name" = "pro-tf-vpc"
  }
}

# subnet
#가용영역 a의 Public Subnet
resource "aws_subnet" "pro_puba" {
  vpc_id            = aws_vpc.pro_vpc.id
  cidr_block        = "172.0.0.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "pro-tf-puba"
  }
}

#가용영역 a의 Private Subnet
resource "aws_subnet" "pro_pria" {
  vpc_id            = aws_vpc.pro_vpc.id
  cidr_block        = "172.0.1.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "pro-tf-pria"
  }
}

#가용영역 a의 db Subnet
resource "aws_subnet" "pro_pridba" {
  vpc_id            = aws_vpc.pro_vpc.id
  cidr_block        = "172.0.2.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "pro-tf-pridba"
  }
}

#가용영역 c의 Public Subnet
resource "aws_subnet" "pro_pubc" {
  vpc_id            = aws_vpc.pro_vpc.id
  cidr_block        = "172.0.3.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "pro-tf-pubc"
  }
}

#가용영역 c의 Private Subnet
resource "aws_subnet" "pro_pric" {
  vpc_id            = aws_vpc.pro_vpc.id
  cidr_block        = "172.0.4.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "pro-tf-pric"
  }
}