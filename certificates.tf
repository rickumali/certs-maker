provider "aws" {
  # Tags to apply to all AWS resources by default
  default_tags {
    tags = {
      "rickumali-com:certs:last-apply-by"        = "Rick Umali"
      "rickumali-com:certs:last-apply-timestamp" = var.timestamp
      "rickumali-com:certs:terraform"            = "aws-tf"
      "rickumali-com:certs:terraform-version"    = var.git_version
      "rickumali-com:certs:environment"          = "Development"
    }
  }
}

resource "aws_acm_certificate" "devcert" {
  for_each = toset(var.cert_names)

  domain_name       = "${each.value}.test.gitmol.com"
  validation_method = "DNS"
}

locals {
  dvos = flatten([for c in aws_acm_certificate.devcert : c.domain_validation_options])
}

resource "aws_route53_record" "dyn_cert_validation" {
  for_each = {
    for d in local.dvos : d.domain_name => {
      name   = d.resource_record_name
      record = d.resource_record_value
      type   = d.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.existing_zone.id
}
