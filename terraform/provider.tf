################################
## AWS Provider Module - Main ##
################################

# Define required providers
terraform {
  # using GitLab http backend
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
  region     = var.aws_region
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
}

