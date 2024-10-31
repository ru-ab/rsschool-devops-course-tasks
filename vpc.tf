resource "aws_vpc" "task_4_vpc" {
  cidr_block = var.vpc.cidr_block

  tags = {
    Name = var.vpc.tag
  }
}

resource "aws_internet_gateway" "task_4_igw" {
  vpc_id = aws_vpc.task_4_vpc.id

  tags = {
    Name = var.igw.tag
  }
}

resource "aws_subnet" "task_4_public_subnet" {
  vpc_id                  = aws_vpc.task_4_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "task_4_public_subnet"
  }
}

resource "aws_route_table" "task_4_public_route_table" {
  vpc_id = aws_vpc.task_4_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task_4_igw.id
  }

  tags = {
    Name = "task_4_public_route_table"
  }
}

resource "aws_route_table_association" "task_4_public_association" {
  subnet_id      = aws_subnet.task_4_public_subnet.id
  route_table_id = aws_route_table.task_4_public_route_table.id
}
