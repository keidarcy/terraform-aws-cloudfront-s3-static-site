###############################################################################
# Terraform Configuration
###############################################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "name" {
  description = "Name for the static site. This will be used as the S3 bucket name and domain name."
  type        = string
}

# Use an existing ACM certificate
variable "acm_certificate_arn" {
  description = "ARN of an existing ACM certificate in us-east-1 region"
  type        = string
}

# Create the static site using the module
module "static_site" {
  source = "../"

  name                = var.name
  acm_certificate_arn = var.acm_certificate_arn

  tags = {
    Environment = "example"
    Terraform   = "true"
  }
}
