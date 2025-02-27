variable "name" {
  description = "Name for the static site. This will be used as the S3 bucket name and domain name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.name))
    error_message = "Name must be a valid S3 bucket name (lowercase alphanumeric characters, dots, and hyphens, must start and end with alphanumeric)."
  }
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate to use for the CloudFront distribution"
  type        = string

  validation {
    condition     = can(regex("^arn:aws:acm:", var.acm_certificate_arn))
    error_message = "The ACM certificate ARN must be a valid ARN starting with 'arn:aws:acm:'."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
