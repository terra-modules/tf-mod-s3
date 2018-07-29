//
// Module: tf-aws-s3
//

# create a bucket
resource "aws_s3_bucket" "b" {
  bucket        = "${local.bucket}"
  region        = "${var.region}"
  force_destroy = "${var.force_destroy}"
  acl           = "${var.acl}"
  tags          = "${local.tags}"

  versioning {
    enabled = "${var.enable_versioning}"
  }

  policy = "${var.policy}"

  # default server side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "${var.sse_algorithm}"
        kms_master_key_id = "${var.kms_master_key_id}"
      }
    }
  }

  # object lifecycle rule - abort incomplete multi-part uploads
  lifecycle_rule {
    enabled                                = "${var.enable_abort_incomplete_multipart_upload}"
    abort_incomplete_multipart_upload_days = "${var.abort_incomplete_multipart_upload_days}"
  }
}

# generate a random alphanumeric string as a bucket suffix
resource "random_id" "server" {
  keepers = {
    # Generate a new id each time we switch to a bucket name
    bucket = "${var.bucket}"
  }

  # hex values are 2 x byte_length
  byte_length = 3
}

# bucket suffix, add hyphen if bucket_suffix != ""
locals {
  bucket_suffix_hyphen = "-${var.bucket_suffix}"
  bucket_suffix        = "${var.bucket_suffix != "" ? local.bucket_suffix_hyphen: var.bucket_suffix }"
}

# random_id suffix, add hyphen, only use if random_id_suffix_enable=1
locals {
  random_id        = "-${random_id.server.hex}"
  random_id_none   = ""
  random_id_suffix = "${var.enable_random_id_suffix ? local.random_id : local.random_id_none }"
}

# Merge bucket name + bucket_suffix + random alpha-numeric suffix
locals {
  bucket = "${var.bucket}${local.bucket_suffix}${local.random_id_suffix}"
}

# Ensure that common_tags get created consistently
locals {
  common_tags = {
    terraform = "true"
  }

  common_tags_merged = "${merge(local.common_tags, var.common_tags)}"
}

# Merge tag sets
locals {
  tags = "${merge(local.common_tags_merged, var.other_tags)}"
}
