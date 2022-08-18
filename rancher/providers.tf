terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.17.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "1.2.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.24.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.3.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
