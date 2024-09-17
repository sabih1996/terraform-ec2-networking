output "public_instance_id" {
  description = "ID of the public EC2 instance"
  value       = aws_instance.public_instance.id
}

output "private_instance_id" {
  description = "ID of the private EC2 instance"
  value       = aws_instance.private_instance.id
}
