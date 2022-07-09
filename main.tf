terraform {
  required_version = ">= 1.2.0"

  cloud {
    organization = "wts"

    workspaces {
      name = "wts-public-gateway-tf"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}