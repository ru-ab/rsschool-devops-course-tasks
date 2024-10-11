resource "aws_launch_template" "bastion_lt" {
  name          = "bastion_lt"
  image_id      = "ami-0ea3c35c5c3284d82"
  instance_type = "t2.micro"

  key_name = "main"

  network_interfaces {
    security_groups = [aws_security_group.allow_ping.id, aws_security_group.allow_ssh.id, aws_security_group.allow_outbound.id]
  }
}

resource "aws_autoscaling_group" "bastion_asg" {
  name                = "bastion_asg"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [for subnet in aws_subnet.public_subnets : subnet.id]

  launch_template {
    id = aws_launch_template.bastion_lt.id
  }

  tag {
    key                 = "Name"
    value               = "bastion"
    propagate_at_launch = true
  }
}
