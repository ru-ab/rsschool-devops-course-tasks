resource "aws_instance" "public_ec2" {
  for_each = {
    for index, subnet in aws_subnet.public_subnets : index => subnet
  }

  ami                    = "ami-0ea3c35c5c3284d82"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ping.id, aws_security_group.allow_ssh.id, aws_security_group.allow_outbound.id]

  subnet_id = each.value.id
  key_name  = "main"

  tags = {
    Name = "public_ec2_${each.key}"
  }
}

resource "aws_instance" "private_ec2" {
  for_each = {
    for index, subnet in aws_subnet.private_subnets : index => subnet
  }

  ami                    = "ami-0ea3c35c5c3284d82"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ping.id, aws_security_group.allow_ssh.id, aws_security_group.allow_outbound.id]

  subnet_id = each.value.id
  key_name  = "main"

  tags = {
    Name = "private_ec2_${each.key}"
  }
}
