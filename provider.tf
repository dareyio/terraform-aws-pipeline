provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "terraform1-imole"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}