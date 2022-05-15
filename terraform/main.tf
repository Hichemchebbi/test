resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "mykey"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]
  tags  = {
    Name  = "Jenkins-server"
  }
  user_data = file("userdata.sh")

  provisioner "file" {
    source      = "../nginxconf/webapp"
    destination = "/etc/nginx/sites-enabled"

    connection {
      type        = "ssh"
      user        = "hichem"
      private_key = "${file("./mykey.pem")}"
      host        = var.ip
    }
  }
  provisioner "file" {
    source      = "../nginxconf/Jenkins"
    destination = "/etc/nginx/sites-enabled"

    connection {
      type        = "ssh"
      user        = "hichem"
      private_key = "${file("./mykey.pem")}"
      host        = "3.72.186.14"
    }
  }
}
