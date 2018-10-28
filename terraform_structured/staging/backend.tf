terraform {
  backend "s3" {
    bucket = "tf-state-structured"
    key = "terraform/staging_state"
    region = "us-east-1"
#    dynamodb_table = "terraform-state-lock"
} }
