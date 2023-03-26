################################
## AWS Provider Module - Main ##
################################

# Define required providers
terraform {
  # using GitLab http backend
  version = "~> 1.4.2"
  # see: https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html
  backend "http" {
    # auto-configured by the template
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Enable the AWS Provider (configured by env variables)
provider "aws" {      
  version = "~> 4.60.0"
  region     = var.aws_region
}

