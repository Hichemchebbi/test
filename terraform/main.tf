resource "aws_instance" "ubuntu-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "mykey"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]
  tags  = {
    Name  = "Jenkins-server"
  }
  user_data = file("userdata.sh")
}
