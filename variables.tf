variable "do_token" {
  description = "DigitalOcean API token"
    type        = string
    sensitive   = true
}
variable "ssh_name" {
  description   = "Ssh keys in DigitalOcean"
    type        = string
    default     = "case" # Keys on Digital Ocean
}
variable "droplet_image" {
  description   = "Image identifier of the OS in DigitalOcean"
    type        = string
    default = "ubuntu-22-04-x64" # OS image 
}
variable "droplet_region" {
  description = "Droplet region identifier where the droplet will be created"
    type        = string
    default = "fra1" # Region
}
variable "droplet_size" {
  description = "Droplet size identifier"
    type        = string
    default = "fra1" # Region = "s-1vcpu-2gb" # Server size
}
variable "user" {
  description = "Username"
    type        = string
    default   = "root"
}
variable "privatekeypath" {
  description = "Privat ssh key"
    type        = string
    default = "~/.ssh/id_ed25519" # your privat ssh key - change it
}

variable "publicekeypath" {
  description = "Public ssh key"
    type        = string
    default = "~/.ssh/id_ed25519.pub" # your public ssh key - change it
}

