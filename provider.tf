provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "cicd-bucket-ada"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"
  }
}