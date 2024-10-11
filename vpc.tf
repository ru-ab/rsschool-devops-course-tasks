resource "aws_vpc" "t2_vpc" {
  cidr_block = var.vpc.cidr_block

  tags = {
    Name = var.vpc.tag
  }
}

resource "aws_internet_gateway" "t2_igw" {
  vpc_id = aws_vpc.t2_vpc.id

  tags = {
    Name = var.igw.tag
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = {
    for index, subnet in var.public_subnets : subnet.cidr_block => subnet
  }

  vpc_id                  = aws_vpc.t2_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.tag
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = {
    for index, subnet in var.private_subnets : subnet.cidr_block => subnet
  }

  vpc_id            = aws_vpc.t2_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.tag
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.t2_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.t2_igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_association" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_ip" {
  for_each = {
    for index, subnet in var.public_subnets : subnet.cidr_block => subnet
  }

  domain = "vpc"

  tags = {
    Name = "nat_ip_${each.key}"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  for_each = aws_subnet.public_subnets

  allocation_id = aws_eip.nat_ip[each.key].id
  subnet_id     = each.value.id
}

resource "aws_route_table" "nat_route_table" {
  for_each = aws_nat_gateway.nat_gw

  vpc_id = aws_vpc.t2_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }

  tags = {
    Name = "nat_route_table_${each.key}"
  }
}

resource "aws_route_table_association" "nat_association" {
  for_each = {
    for index, subnet in var.private_subnets : subnet.cidr_block => subnet
  }

  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.nat_route_table[each.value.nat_gw_subnet].id
}
