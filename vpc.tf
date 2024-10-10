resource "aws_vpc" "t2_vpc" {
  cidr_block = local.vpc.cidr_block

  tags = {
    Name = local.vpc.tag
  }
}

resource "aws_internet_gateway" "t2_igw" {
  vpc_id = aws_vpc.t2_vpc.id

  tags = {
    Name = local.igw.tag
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = {
    for index, subnet in local.public_subnets : subnet.cidr_block => subnet
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
    for index, subnet in local.private_subnets : subnet.cidr_block => subnet
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
