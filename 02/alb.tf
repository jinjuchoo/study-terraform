resource "aws_lb" "jinju-alb" {
  name               = "jinju-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.jinju-subnet1.id, aws_subnet.jinju-subnet2.id]
  security_groups = [aws_security_group.jinju-sg.id]

  tags = {
    Name = "jinju-alb"
  }
}

resource "aws_lb_listener" "jinju-http" {
  load_balancer_arn = aws_lb.jinju-alb.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found - jinju Study"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "jinju-albtg" {
  name = "jinju-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.jinju-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "jinju-albrule" {
  listener_arn = aws_lb_listener.jinju-http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jinju-albtg.arn
  }
}

output "jinju-alb_dns" {
  value       = aws_lb.jinju-alb.dns_name
  description = "The DNS Address of the ALB"
}
