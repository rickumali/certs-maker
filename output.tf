output "cert_domain_names" {
  value       = values(aws_acm_certificate.devcert)[*].domain_name
  description = "Certificate names"
}
