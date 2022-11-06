resource "aws_security_group" "jinju-sg" {
  vpc_id      = aws_vpc.jinju-vpc.id
  name        = "jinju SG"
  description = "jinju tf SG"
}

resource "aws_security_group_rule" "jinju-sginbound" {
  type              = "ingress"
  from_port         = 0
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jinju-sg.id
}

resource "aws_security_group_rule" "jinju-sgoutbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.jinju-sg.id
}
