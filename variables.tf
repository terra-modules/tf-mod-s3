//
// Module: tf-aws-s3
//
//  Variables
//

# aws_s3_bucket - terraform docs
# https://www.terraform.io/docs/providers/aws/r/s3_bucket.html

# Required
# --------

variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
}

# Optional
# --------

variable "bucket" {
  description = "Bucket name"
  default     = "my-s3-bucket"
}

variable "region" {
  description = "If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee"
  default     = "eu-west-1"
}

variable "bucket_suffix" {
  description = "enable bucket name suffix eg my-bucket-suffix"
  default     = ""
}

variable "enable_random_id_suffix" {
  description = "enable random_id suffix on bucket name eg my-bucket-de48g5"
  default     = false
}

# https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl
variable "acl" {
  description = "Set canned ACL on bucket. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, bucket-owner-read, bucket-owner-full-control, log-delivery-write"
  default     = "private"
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  default     = false
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error"
  default     = false
}

variable "common_tags" {
  description = "Deloitte Cloud common tags for bucket"
  type        = "map"

  default = {
    terraform = "true"
  }
}

variable "other_tags" {
  description = "other tags for bucket"
  type        = "map"
  default     = {}
}

variable "prevent_destroy" {
  description = "lifecycle rule to prevent the removal of a bucket during a destroy"
  default     = false
}

# Default server side encryption configuration

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
  default     = "AES256"
}

variable "kms_master_key_id" {
  description = "The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms"
  default     = ""
}

# lifecycle rule - abort multi-part uploads

variable "enable_abort_incomplete_multipart_upload" {
  description = "Lifecycle rule to abort incomplete multi-part uploads after a certain time"
  default     = false
}

variable "abort_incomplete_multipart_upload_days" {
  description = "No. of days to wait before aborting incomplete multi-part uploads"
  default     = "7"
}

variable "policy" {
  description = "Policy to add to bucket"
  default     = ""
}
