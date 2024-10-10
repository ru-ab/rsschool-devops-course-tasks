resource "aws_network_acl" "t2_acl" {
  vpc_id = aws_vpc.t2_vpc.id

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "icmp"
    icmp_type  = 8
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 110
    action     = "allow"
    protocol   = "icmp"
    icmp_type  = 0
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    rule_no    = 200
    action     = "allow"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 300
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_network_acl_association" "public_acl_associations" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  network_acl_id = aws_network_acl.t2_acl.id
}
