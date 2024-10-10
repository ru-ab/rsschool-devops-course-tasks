locals {
  vpc = {
    cidr_block = "10.0.0.0/16"
    tag        = "t2_vpc"
  }

  igw = {
    tag = "t2_igw"
  }

  public_subnets = [{
    cidr_block        = "10.0.11.0/24"
    availability_zone = "us-east-2a"
    tag               = "public_subnet_1"
    }, {
    cidr_block        = "10.0.21.0/24"
    availability_zone = "us-east-2b"
    tag               = "public_subnet_2"
  }]

  private_subnets = [{
    cidr_block        = "10.0.12.0/24"
    availability_zone = "us-east-2a"
    tag               = "private_subnet_1"
    }, {
    cidr_block        = "10.0.22.0/24"
    availability_zone = "us-east-2b"
    tag               = "private_subnet_2"
  }]
}
