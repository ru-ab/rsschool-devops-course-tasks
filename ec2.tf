resource "aws_instance" "task_3_control_plane_ec2" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t3.small"

  vpc_security_group_ids = [aws_security_group.task_3_host_sg.id]

  subnet_id = aws_subnet.task_3_private_subnets[var.private_subnets[0].cidr_block].id
  key_name  = "main"

  tags = {
    Name = "task_3_control_plane_ec2"
  }
}

resource "aws_instance" "task_3_worker_ec2" {
  count = 1

  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.task_3_host_sg.id]

  subnet_id = aws_subnet.task_3_private_subnets[var.private_subnets[0].cidr_block].id
  key_name  = "main"

  tags = {
    Name = "task_3_worker_ec2_${count.index}"
  }
}
