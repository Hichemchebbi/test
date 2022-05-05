variable "region" {
  type    = string 
  description = "Region added in tfvars"
}
variable "instance_type" {
  type = string 
  default = "t2.medium"
}
variable "ami" {
  type    = string 
  description = "ami added in tfvars"
}

variable "public_key"{
    description = "ssh public key"
}