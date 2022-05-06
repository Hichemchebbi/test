resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "mykey"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]

#terraform remote exec 
  provisioner "file" {
    source      = "userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "/tmp/userdata.sh args",
    ]
  }

  tags  = {
    Name  = "Jenkins-server"
  }
  user_data = file("userdata.sh")
}

