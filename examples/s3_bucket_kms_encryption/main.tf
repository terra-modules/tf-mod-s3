# Create a local state backend
terraform {
  backend "local" {
    path = ".terraform/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-west-1"
}

# Create a bucket
module "my_bucket" {
  source                                      = "../../"
  bucket                                      = "test-bucket"
  acl                                         = "private"
  sse_algorithm                               = "aws:kms"
  enable_versioning                           = true
  enable_random_id_suffix                     = true
  enable_abort_incomplete_multipart_upload    = true
  abort_incomplete_multipart_upload_days      = 7

  common_tags  = {
                  terraform   =   "true"
                  project_id   =  "p000123"
                  project_name =  "project xxx"
                  environment  =  "sbx"
                  component    =  "bucket"
                }

}

resource "aws_kms_key" "a" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 7
}

resource "aws_kms_alias" "a" {
  name          = "alias/my-key-alias"
  target_key_id = "${aws_kms_key.a.key_id}"
}
