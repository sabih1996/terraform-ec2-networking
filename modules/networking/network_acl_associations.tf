resource "aws_network_acl_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  network_acl_id = aws_network_acl.main_acl.id
}

resource "aws_network_acl_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  network_acl_id = aws_network_acl.main_acl.id
}
