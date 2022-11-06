provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_vpc" "jinju-vpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "jinju-vpc"
  }
}

resource "aws_subnet" "jinju-subnet1" {
  vpc_id     = aws_vpc.jinju-vpc.id
  cidr_block = "10.10.1.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "jinju-subnet1"
  }
}

resource "aws_subnet" "jinju-subnet2" {
  vpc_id     = aws_vpc.jinju-vpc.id
  cidr_block = "10.10.2.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "jinju-subnet2"
  }
}

resource "aws_internet_gateway" "jinju-igw" {
    vpc_id = aws_vpc.jinju-vpc.id
  
    tags = {
      Name = "jinju-igw"
    }
  }

  resource "aws_route_table" "jinju-rt" {
    vpc_id = aws_vpc.jinju-vpc.id
  
    tags = {
      Name = "jinju-rt"
    }
  }
  
  resource "aws_route_table_association" "jinju-rtassociation1" {
    subnet_id      = aws_subnet.jinju-subnet1.id
    route_table_id = aws_route_table.jinju-rt.id
  }
  
  resource "aws_route_table_association" "jinju-rtassociation2" {
    subnet_id      = aws_subnet.jinju-subnet2.id
    route_table_id = aws_route_table.jinju-rt.id
  }
  
  resource "aws_route" "jinju-defaultroute" {
    route_table_id         = aws_route_table.jinju-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.jinju-igw.id
  }
