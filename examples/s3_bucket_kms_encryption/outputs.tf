# The name of the bucket.
output "id" {
   value = "${module.my_bucket.id}"
}

# The ARN of the bucket. Will be of format arn:aws:s3:::bucketname
output "arn" {
   value = "${module.my_bucket.arn}"
}


# The AWS region this bucket resides in
output "region" {
   value = "${module.my_bucket.region}"
}
