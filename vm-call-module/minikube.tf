# resource "null_resource" "install_minikube" {
#   triggers = {
#     vm_id = module.create_VM.vm_id
#     force_recreate = timestamp()
#   }
#   depends_on = [null_resource.install_docker]
#
#   connection {
#     type        = "ssh"
#     host        = module.create_VM.vm_ip
#     user        = module.create_VM.vm_admin_username
#     private_key = file("~/.ssh/id_rsa")
#   }
#
#   provisioner "remote-exec" {
#     inline = [
#       "curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
#       "sudo install minikube-linux-amd64 /usr/local/bin/minikube",
#       "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
#       "chmod +x kubectl",
#       "sudo mv kubectl /usr/local/bin/",
#       "minikube start --driver=docker",
#       "sudo mkdir -p /var/lib/jenkins/.minikube",
#       "sudo cp -r ~/.minikube/* /var/lib/jenkins/.minikube/",
#       "sudo chown -R jenkins:jenkins /var/lib/jenkins/.minikube",
#     ]
#   }
# }