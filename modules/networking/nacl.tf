resource "aws_network_acl" "main_acl" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Main Network ACL"
  }
}

# Allow HTTP (80) inbound traffic from all IPs
resource "aws_network_acl_rule" "http_inbound" {
  network_acl_id = aws_network_acl.main_acl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

# Allow HTTPS (443) inbound traffic from all IPs
resource "aws_network_acl_rule" "https_inbound" {
  network_acl_id = aws_network_acl.main_acl.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

# Allow SSH (22) inbound from trusted IP
resource "aws_network_acl_rule" "ssh_inbound" {
  network_acl_id = aws_network_acl.main_acl.id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Replace with your trusted IP rather than this one 
  from_port      = 22
  to_port        = 22
}

# Deny all other inbound traffic
resource "aws_network_acl_rule" "deny_all_inbound" {
  network_acl_id = aws_network_acl.main_acl.id
  rule_number    = 400
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "0.0.0.0/0"
}

# Allow all outbound traffic
resource "aws_network_acl_rule" "allow_all_outbound" {
  network_acl_id = aws_network_acl.main_acl.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}
