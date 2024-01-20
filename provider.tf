provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "tyla-cicd"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}