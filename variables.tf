variable "key_name" {
  description = "Private key to use with EC2 instance"
  default = "Linux-instance"
}

variable "instance_type" {
  description = "AWS instance type"
  default = "t3.small"
}

variable "ami" {
    description = "Base ami to launch the instance"
    default = "ami-13be557e"
  
}

