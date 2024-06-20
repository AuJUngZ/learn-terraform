# # Install Docker on the virtual machine
# resource "null_resource" "install_docker" {
#   triggers = {
#     vm_id = module.create_VM.vm_id
#   }
#   depends_on = [null_resource.install_jenkins]
#
#   connection {
#     type        = "ssh"
#     host        = module.create_VM.vm_ip
#     user        = module.create_VM.vm_admin_username
#     private_key = file("~/.ssh/id_rsa")
#   }
#
#   # Remove old Docker packages
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get remove -y docker docker-engine docker.io containerd runc || true",
#     ]
#   }
#
#   # Install Docker
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update -y",
#       "sudo apt-get install -y -o=APT::Get::Assume-Yes=true ca-certificates curl gnupg lsb-release",
#       "sudo rm -rf /etc/apt/keyrings",
#       "sudo mkdir -p /etc/apt/keyrings",
#       "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
#       "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
#       "sudo apt-get update -y",
#       "sudo apt-get install -y -o=APT::Get::Assume-Yes=true docker-ce docker-ce-cli containerd.io",
#       "sudo usermod -aG docker ${module.create_VM.vm_admin_username}",
#     ]
#   }
#
#   # Configure Docker daemon
#   provisioner "remote-exec" {
#     inline = [
#       "sudo mkdir -p /etc/docker",
#       "sudo tee /etc/docker/daemon.json > /dev/null <<EOF",
#       "{",
#       "  \"log-driver\": \"json-file\",",
#       "  \"log-opts\": {",
#       "    \"max-size\": \"10m\",",
#       "    \"max-file\": \"3\"",
#       "  }",
#       "}",
#       "EOF",
#       "sudo systemctl daemon-reload",
#       "sudo systemctl restart docker",
#     ]
#   }
#
#   #   Add docker group to the user jenkins
#   provisioner "remote-exec" {
#     inline = [
#       "sudo usermod -aG docker jenkins",
#       "sudo usermod -aG docker ${module.create_VM.vm_admin_username}",
#       "sudo systemctl restart jenkins",
#       "sudo systemctl restart docker",
#     ]
#   }
# }