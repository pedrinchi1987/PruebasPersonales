terraform {
  cloud {
    organization = "PruebasPersonales"

    workspaces {
      name = "PruebasPersonales"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key

  default_tags {
    tags = {
      Owner   = "PRMR"
      Project = "Test"
    }
  }
}
