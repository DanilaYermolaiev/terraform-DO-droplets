# Define required providers
terraform {
  # required_version = ">= 1.4.2"
  # using GitLab http backend
  # see: https://docs.gitlab.com/ee/user/infrastructure/terraform_state.html
  backend "http" {
    # auto-configured by the template
  }
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}
provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "ssh" {
  name = var.ssh_name
}