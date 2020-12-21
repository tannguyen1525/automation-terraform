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

variable "sg_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "test"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "test"
        },
    ]
}
