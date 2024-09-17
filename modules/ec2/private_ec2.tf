resource "aws_instance" "private_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = [var.private_sg]

  tags = {
    Name = "Private EC2 Instance"
  }
}
