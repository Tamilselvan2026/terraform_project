data "aws_route53_zone" "main" {
  name         = "tamilselvanr.online"
  private_zone = false
}

data "aws_acm_certificate" "alb" {
  domain      = "www.tamilselvanr.online"
  statuses    = ["ISSUED"]
  most_recent = true
}

