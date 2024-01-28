provider "aws" {
  region = local.region
}

terraform {
  backend "s3" {
    bucket = "busipieterson-cicd-pipeline"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}
