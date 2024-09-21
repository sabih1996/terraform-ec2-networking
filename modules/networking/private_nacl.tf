resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [aws_subnet.private.id]

  tags = {
    Name = "Private NACL"
  }
}

# Inbound Rules for Private Subnet NACL (only VPC internal)
resource "aws_network_acl_rule" "private_nacl_inbound_http" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "private_nacl_inbound_https" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "private_nacl_inbound_ssh" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  from_port      = 22
  to_port        = 22
}

# Outbound Rules for Private Subnet NACL (allow any outbound)
resource "aws_network_acl_rule" "private_nacl_outbound_any" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Deny all other inbound traffic
resource "aws_network_acl_rule" "private_nacl_deny_all_inbound" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 400
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
}

# Deny all other outbound traffic
resource "aws_network_acl_rule" "private_nacl_deny_all_outbound" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 400
  egress         = true
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
}
