provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "busi-cicd-class"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
