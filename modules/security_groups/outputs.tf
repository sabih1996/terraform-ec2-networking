# Output for public security group
output "public_sg_id" {
  description = "ID of the public security group"
  value       = aws_security_group.public_sg.id
}

# Output for private security group
output "private_sg_id" {
  description = "ID of the private security group"
  value       = aws_security_group.private_sg.id
}
