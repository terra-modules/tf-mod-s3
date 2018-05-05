# Create a local state backend
terraform {
  backend "local" {
    path = ".terraform/terraform.tfstate"
  }
}


# Create a bucket
module "my_bucket" {
  source                                      = "../../"
  bucket                                      = "test-bucket"
  acl                                         = "private"
  sse_algorithm                               = "AES256"
  enable_versioning                           = true
  enable_random_id_suffix                     = true
  enable_abort_incomplete_multipart_upload    = true
  abort_incomplete_multipart_upload_days      = 7

  common_tags  = {
                  "terraform"   =  "true"
                  "project_id"   =  "p000123"
                  "project_name" =  "project xxx"
                  "environment"  =  "sbx"
                  "component"    =  "bucket"
                }

}
