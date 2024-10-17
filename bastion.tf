resource "aws_instance" "task_3_bastion_ec2" {
  ami                    = data.aws_ami.ubuntu22.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.task_3_bastion_sg.id]

  subnet_id = aws_subnet.task_3_public_subnets[var.public_subnets[0].cidr_block].id
  key_name  = "main"

  tags = {
    Name = "task_3_bastion_ec2"
  }
}
