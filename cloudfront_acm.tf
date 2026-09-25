resource "aws_acm_certificate" "cloudfront" {
  provider = aws.us_east_1

  domain_name = "www.tamilselvanr.online"

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "terraform-cloudfront-certificate"
  }
}

resource "aws_route53_record" "cloudfront_validation" {
  zone_id = data.aws_route53_zone.main.zone_id

  name = tolist(
    aws_acm_certificate.cloudfront.domain_validation_options
  )[0].resource_record_name

  type = tolist(
    aws_acm_certificate.cloudfront.domain_validation_options
  )[0].resource_record_type

  records = [
    tolist(
      aws_acm_certificate.cloudfront.domain_validation_options
    )[0].resource_record_value
  ]

  ttl = 60

  allow_overwrite = true
}


resource "aws_acm_certificate_validation" "cloudfront" {
  provider = aws.us_east_1

  certificate_arn = aws_acm_certificate.cloudfront.arn

  validation_record_fqdns = [
    aws_route53_record.cloudfront_validation.fqdn
  ]
}