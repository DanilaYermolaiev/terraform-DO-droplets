# Droplet
resource "digitalocean_droplet" "web" {
  image              = var.droplet_image
  name               = var.droplet_name
  region             = var.droplet_region
  size               = var.droplet_size
  backups            = false
  monitoring         = true
  ssh_keys = [
    data.digitalocean_ssh_key.ssh.id
    ]

  ## Files
  provisioner "file" {
    source = "files/installations.sh"
    destination = "installations.sh"

    connection {
    host = self.ipv4_address
    type = "ssh"
    user  = var.user
    private_key = file(var.privatekeypath)
    agent  = false
    timeout  = "90s"

    } 
  }
  provisioner "remote-exec" {
    connection {
    host = self.ipv4_address
    type = "ssh"
    user  = var.user
    private_key = file(var.privatekeypath)
    agent  = false
    timeout  = "90s"

    } 
    inline = [
      "chmod +x ~/installations.sh",
      "cd ~/",
      "./installations.sh"
        ]
  }
}

# Firewall
resource "digitalocean_firewall" "web" {
  name = "only-allow-ssh-http-and-https"

  droplet_ids = [digitalocean_droplet.web.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

