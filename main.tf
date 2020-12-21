# Terraform state will be store in S3
terraform {
  backend "s3" {
      bucket = "terraform-bucket-tannm"
      key = "terraform.tfstate"
      encrypt = "true"
      region = "us-east-1"
  }
}

# Use AWS Terraform provider
provider "aws"  {
    region = "us-east-1"
  
}

# Create EC2 instance
resource "aws_instance" "default" {
    ami = "$(var.ami)"
    //count = "$(var.count)"
    key_name = "$(var.key_name)"
    vpc_security_group_ids = [ "$(aws_security_group_rule.ingress_rules.id)" ]
    source_dest_check = false
    instance_type = "$(var.instance_type)"

    tags = {
        Name = "EC2-linux"
    }
  
}

# Create Security Group for EC2
resource "aws_security_group_rule" "ingress_rules" {
  count = length(var.ingress_rules)
  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.ec2_security_groups.id
}