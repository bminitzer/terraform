resource "aws_acm_certificate" "gateway" {
  domain_name       = "${var.environmentshort}.domain.com"
  validation_method = "DNS"
  subject_alternative_names = [
    "*.${var.environmentshort}.domain.com"
  ]
}

data "aws_route53_zone" "gateway" {
  name         = "domain.com"
  private_zone = false
}

resource "aws_route53_record" "gateway" {
  for_each = {
    for dvo in aws_acm_certificate.gateway.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.gateway.zone_id
}

resource "aws_acm_certificate_validation" "gateway" {
  certificate_arn         = aws_acm_certificate.gateway.arn
  validation_record_fqdns = [for record in aws_route53_record.gateway : record.fqdn]
}

resource "aws_route53_record" "route53-record-NLB2" {
  zone_id = var.route53-zone-id
  name    = "api.dev.domain.com"
  type    = "CNAME"
  ttl     = 300
  records = [aws_alb.main.dns_name]
}
