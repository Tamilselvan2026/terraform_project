resource "aws_lb_target_group" "oregan_vpc_alb_tg" {
  name     = "oregan-vpc-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.oregan_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "oregan_vpc_alb_tg"
  }
}

resource "aws_lb" "oregan_vpc_alb" {
  name               = "oregan-vpc-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.oregan_vpc_public[*].id
  tags = {
    Name = "oregan_vpc_alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.oregan_vpc_alb.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.oregan_vpc_alb_tg.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.oregan_vpc_alb.arn

  port     = 443
  protocol = "HTTPS"

  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  certificate_arn = data.aws_acm_certificate.alb.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.oregan_vpc_alb_tg.arn
  }
}