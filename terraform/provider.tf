################################
## AWS Provider Module - Main ##
################################

# Define required providers
terraform {
  required_version = ">= 1.4.2"
  # using GitLab http backend
  # see: https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html
  backend "http" {
    # auto-configured by the template
  }
  required_providers {
    aws = {
      version = "~> 4.60.0"
      source  = "hashicorp/aws"
    }
    tls = {
      version = "~> 4.0.4"
    }
  }
}

# Enable the AWS Provider (configured by env variables)
provider "aws" {      
  region     = var.aws_region
}

