provider "aws" {
    region = "ap-northeast-2"
}

variable "internet_gateway_enalbed" {
    type = bool
    default = true
}

resource "aws_vpc" "this" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "this" {
    count = var.internet_gateway_enalbed ? 1 : 0

    vpc_id = aws_vpc.this.id
}