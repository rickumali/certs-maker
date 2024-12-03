variable "cert_names" {
  description = "Create certificates with these names"
  type        = list(string)
  default     = ["web", "whoami", "httpbin"]
}

variable "git_version" {
  description = "Branch and SHA1 ID of certs project"
  type        = string
}

variable "timestamp" {
  description = "YYYYMMDD-HHMM (24 hour time)"
  type        = string
}
