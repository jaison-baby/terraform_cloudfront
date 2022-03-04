provider "aws" {
    region = var.AWS_REGION
    access_key = var.instance_accesskey
    secret_key = var.instance_secretkey
}
module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = var.bucket_name
  tags = var.tags
  cloudfront_origin_arn = module.cloudfront.cloudfront_identity 
}

module "cloudfront" {
    source = "./modules/CF"
    s3_domain = module.website_s3_bucket.domain
}
