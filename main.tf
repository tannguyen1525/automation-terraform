# Use AWS Terraform provider
provider "aws"  {
    region = "us-east-1"
  
}

resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "VPC-main"
    }
}

# Subnet
resource "aws_subnet" "main-public-1"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet_public"
    }
}

resource "aws_subnet" "main-private-1"{
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"
    tags = {
        Name = "subnet_private"
    }
}

# Internet GW
resource "aws_internet_gateway" "main-gw"{
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "IGW-main"
    }
}

# Route tables
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
       
    }

     tags = {
            Name = "main-public-1"
        }
}

# Route associations public
resource "aws_route_table_association" "main-public-1-a"{
    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_security_group" "allow-ssh" {
    vpc_id = aws_vpc.main.id
    name = "allow-ssh"
    description = "security group that allows ssh and all egress traffic"
    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress  {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-ssh"
    }
    
}

# EC2 instance
resource "aws_instance" "example"{
    ami             = var.ami
    instance_type   = "t2.micro"
    key_name = "Linux-instance"

    tags = {
        Name = "VM-test"
    }

    # create root block device (optional)
    root_block_device {
        volume_size = 10
        volume_type = "gp2"
        delete_on_termination = true # whether to delete root block device when the insance gets terminated or not
    }

    # the VPC subnet
    subnet_id = aws_subnet.main-public-1.id

    # the security grup
    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

    # the public SSH key
    #key_name = "${aws_key_pair.mykeypair.key_name}"
}