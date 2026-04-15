output "aws_instance_public_ip" {
    value = aws_instance.my_instance[*].public_ip
    description = "Public IP address of the ec2 instance"
}