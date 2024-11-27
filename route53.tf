data "aws_route53_zone" "existing_zone" {
  name = "test.gitmol.com"
}

resource "aws_route53_record" "placeholder_record" {
  for_each = toset(var.cert_names)

  zone_id = data.aws_route53_zone.existing_zone.id
  name    = "${each.value}.test.gitmol.com"
  type    = "TXT"
  ttl     = 300

  records = ["Record 1", "Record 2"]
}
