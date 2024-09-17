output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id  
}

# Output for public subnet
output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

# Output for private subnet
output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}
