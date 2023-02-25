# Droplet
resource "digitalocean_droplet" "web" {
  image              = var.droplet_image
  name               = "dev-${count.index}"
  region             = var.droplet_region
  size               = var.droplet_size
  backups            = false
  monitoring         = true
  count  = 1
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
    timeout  = "160s"

    } 
    inline = [
      "sudo apt update && apt  upgrade", "sudo apt install python3 git httpie jq -y", "echo Done!"
      # "chmod +x ~/installations.sh",
      # "cd ~/",
      # "./installations.sh"
        ]
  }
    provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -vvv -u root -i '${self.ipv4_address},' --private-key ${var.privatekeypath} -e 'pub_key=${var.publicekeypath}' files/install.yml"

  }
}

# Firewall
resource "digitalocean_firewall" "web" {
  name = "firewall-${random_string.random.result}"

  # droplet_ids = [digitalocean_droplet.web.id]

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

resource "random_string" "random" {
  length  = 3
  upper   = false
  special = false
}

output "droplet_output" {
  value = {
    for droplet in digitalocean_droplet.web:
    droplet.name => droplet.ipv4_address
  }
}
