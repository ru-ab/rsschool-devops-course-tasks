resource "aws_instance" "task_4_k3s_ec2" {
  ami           = data.aws_ami.ubuntu22.id
  instance_type = "t3.small"

  subnet_id = aws_subnet.task_4_public_subnet.id
  key_name  = "main"

  vpc_security_group_ids = [aws_security_group.task_4_host_sg.id]

  tags = {
    Name = "task_4_k3s_ec2"
  }
}
