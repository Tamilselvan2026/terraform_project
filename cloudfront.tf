resource "aws_cloudfront_distribution" "web" {
  enabled = true

  comment = "Terraform Web Application"

  aliases = [
    "www.tamilselvanr.online"
  ]

  origin {
    domain_name = aws_lb.oregan_vpc_alb.dns_name

    origin_id = "terraform-alb-origin"

    custom_origin_config {
      http_port  = 80
      https_port = 443

      origin_protocol_policy = "http-only"

      origin_ssl_protocols = [
        "TLSv1.2"
      ]
    }
  }

  default_cache_behavior {
    target_origin_id = "terraform-alb-origin"

    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS"
    ]

    cached_methods = [
      "GET",
      "HEAD"
    ]

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    compress = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cloudfront.certificate_arn

    ssl_support_method = "sni-only"

    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = {
    Name = "terraform-web-cloudfront"
  }
}


resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.main.zone_id

  name = "www.tamilselvanr.online"

  type = "A"

  alias {
    name                   = aws_cloudfront_distribution.web.domain_name
    zone_id                = aws_cloudfront_distribution.web.hosted_zone_id
    evaluate_target_health = false
  }
}