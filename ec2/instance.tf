resource "aws_key_pair" "my_key" {
    key_name = "terra-keyy"
    public_key = file("terra-keyy.pub")
}

#vpc & security group

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my-sg" {
    name = "my-sg"
    description = "Security group for my ec2 instance via terraform"
    vpc_id = aws_default_vpc.default.id

    tags = {
        Name = "my-sg"
    }

    #inbound rules 

    ingress { 
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow ssh"

    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP enabled"
    }

    #outbound rules

    egress {
        from_port = 0
        to_port =0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow all outbound traffic"
    }
}

#ec2 instance 

resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my-sg.name]
    instance_type = "t3.micro"
    ami = "ami-05d2d839d4f73aafb" 
    user_data = file("installnginx.sh")


    root_block_device {
        volume_size = 15
        volume_type = "gp2"

    }
    
    tags = {
        Name = "my-terra-instance"
    }
}