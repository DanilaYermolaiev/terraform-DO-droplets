variable "do_token" {
  description = "DigitalOcean API token"
    type        = string
    sensitive   = true
}
variable "ssh_name" {
  description   = "Ssh keys in DigitalOcean"
    type        = string
}
variable "droplet_image" {
  description   = "Image identifier of the OS in DigitalOcean"
    type        = string
}
variable "droplet_region" {
  description = "Droplet region identifier where the droplet will be created"
    type        = string
}
variable "droplet_size" {
  description = "Droplet size identifier"
    type        = string
}
variable "user" {
  description = "Username"
    type        = string
}
variable "privatekeypath" {
  description = "Privat ssh key"
    type        = string
}

variable "publicekeypath" {
  description = "Public ssh key"
    type        = string
}

