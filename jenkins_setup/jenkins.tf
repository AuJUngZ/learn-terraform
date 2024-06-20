resource "null_resource" "install_jenkins" {
  triggers = {
    vm_id = azurerm_linux_virtual_machine.vm.id
  }

  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.vm.public_ip_address
    user        = azurerm_linux_virtual_machine.vm.admin_username
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y openjdk-11-jdk",
      "sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key",
      "echo \"deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/\" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get install -y jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins"
    ]
  }
}
