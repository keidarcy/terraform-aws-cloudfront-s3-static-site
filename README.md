# AWS CloudFront S3 Static Site Terraform Module

This Terraform module creates an S3 bucket for static website hosting and sets up a CloudFront distribution with HTTPS support. The module is designed to be secure by default, using CloudFront Origin Access Control (OAC) to ensure the S3 bucket is only accessible through CloudFront.

## Features

- Creates an S3 bucket for static website hosting
- Sets up CloudFront distribution with HTTPS support
- Uses CloudFront Origin Access Control (OAC) for secure S3 access
- Configures proper bucket policies and access controls
- Supports custom domain names with ACM certificates
- Enables Single Page Application (SPA) support by redirecting 404s to index.html

## Prerequisites

- AWS account
- Terraform 1.0+
- ACM certificate in the `us-east-1` region (required for CloudFront)
- Domain name matching the ACM certificate

## Usage

```hcl
variable "name" {
  description = "Name for the static site. This will be used as the S3 bucket name and domain name."
  type        = string
}

variable "acm_certificate_arn" {
  description = "ARN of an existing ACM certificate in us-east-1 region"
  type        = string
}

module "static_site" {
  source = "keidarcy/cloudfront-s3-static-site/aws"

  name                = var.name
  acm_certificate_arn = var.acm_certificate_arn

  tags = {
    Environment = "example"
    Terraform   = "true"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aws | >= 4.0.0 |

## Inputs

| Name | Description | Type | Required | Default |
|------|-------------|------|----------|---------|
| name | Name for the static site. This will be used as the S3 bucket name and domain name. Must be a valid S3 bucket name. | `string` | yes | |
| acm_certificate_arn | ARN of the ACM certificate to use for the CloudFront distribution. Must be in us-east-1 region. | `string` | yes | |
| tags | Tags to apply to all resources | `map(string)` | no | `{}` |
| enable_bucket_versioning | Enable versioning for the S3 bucket | `bool` | no | `true` |

## Outputs

| Name | Description |
|------|-------------|
| cloudfront_distribution_id | The ID of the CloudFront distribution |
| cloudfront_distribution_domain_name | The domain name of the CloudFront distribution |
| s3_bucket_name | The name of the S3 bucket |
| s3_bucket_arn | The ARN of the S3 bucket |

## Security Features

1. S3 bucket is completely private
   - Public access is blocked
   - Bucket policy only allows access from CloudFront
   - Versioning is enabled by default (can be disabled via `enable_bucket_versioning` variable)

2. CloudFront security features
   - HTTPS only (redirects HTTP to HTTPS)
   - TLS 1.2 minimum protocol version
   - Uses Origin Access Control (OAC) with sigv4 signing

## Notes

1. The ACM certificate must be in the `us-east-1` region as that's required by CloudFront
2. The domain name used should match or be a subdomain of the domain in the ACM certificate
3. The S3 bucket name will be the same as the domain name, so it must be globally unique
4. The module enables SPA support by redirecting 404 errors to index.html

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This module is released under the MIT License.
