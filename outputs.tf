#####################################
## Virtual Machine Module - Output ##
#####################################

output "vm_linux_server_instance_id" {
  value = aws_instance.webserver.id
}

output "vm_linux_server_instance_public_dns" {
  value = aws_instance.webserver.public_dns
}

output "vm_linux_server_instance_public_ip" {
  value = aws_eip_association.linux-eip-association.public_ip
}

output "vm_linux_server_instance_private_ip" {
  value = aws_instance.webserver.private_ip
}