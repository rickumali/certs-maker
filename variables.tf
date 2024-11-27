variable "cert_names" {
  description = "Create certificates with these names"
  type        = list(string)
  default     = ["web", "whoami", "httpbin"]
}
