provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "terraform-eh"
    key    = "terraform"
    region = "eu-west-1"
  }
}
