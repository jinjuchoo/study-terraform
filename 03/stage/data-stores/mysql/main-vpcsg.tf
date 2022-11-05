terraform {
  backend "s3" {
    bucket = "jinju-t101study-tfstate-week3-files"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "terraform-locks-week3-files"
  }
}

provider "aws" {
  region  = "ap-northeast-2"
}

resource "aws_vpc" "jinju-vpc" {
  cidr_block       = "10.10.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "jinju-t101-study"
  }
}

resource "aws_subnet" "jinju-subnet3" {
  vpc_id     = aws_vpc.jinju-vpc.id
  cidr_block = "10.10.3.0/24"

  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "jinju-t101-subnet3"
  }
}

resource "aws_subnet" "jinju-subnet4" {
  vpc_id     = aws_vpc.jinju-vpc.id
  cidr_block = "10.10.4.0/24"

  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "jinju-t101-subnet4"
  }
}

resource "aws_route_table" "jinju-rt2" {
  vpc_id = aws_vpc.jinju-vpc.id

  tags = {
    Name = "jinju-t101-rt2"
  }
}

resource "aws_route_table_association" "jinju-rtassociation3" {
  subnet_id      = aws_subnet.jinju-subnet3.id
  route_table_id = aws_route_table.jinju-rt2.id
}

resource "aws_route_table_association" "jinju-rtassociation4" {
  subnet_id      = aws_subnet.jinju-subnet4.id
  route_table_id = aws_route_table.jinju-rt2.id
}

resource "aws_security_group" "jinju-sg2" {
  vpc_id      = aws_vpc.jinju-vpc.id
  name        = "jinju-t101 SG - RDS"
  description = "jinju-t101 Study SG - RDS"
}

resource "aws_security_group_rule" "rdssginbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jinju-sg2.id
}

resource "aws_security_group_rule" "rdssgoutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jinju-sg2.id
}
