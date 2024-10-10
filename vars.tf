variable "region" {
  description = "Defines AWS region"
  default     = "us-east-2"
  type        = string
}

variable "vpc" {
  type = object({
    cidr_block = string
    tag        = string
  })
  default = {
    cidr_block = "10.0.0.0/16"
    tag        = "t2_vpc"
  }
}

variable "igw" {
  type = object({
    tag = string
  })
  default = {
    tag = "t2_igw"
  }
}

variable "public_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tag               = string
  }))
  default = [{
    cidr_block        = "10.0.11.0/24"
    availability_zone = "us-east-2a"
    tag               = "public_subnet_1"
    }, {
    cidr_block        = "10.0.21.0/24"
    availability_zone = "us-east-2b"
    tag               = "public_subnet_2"
  }]
}

variable "private_subnets" {
  type = list(object({
    cidr_block        = string
    nat_gw_subnet     = string
    availability_zone = string
    tag               = string
  }))
  default = [{
    cidr_block        = "10.0.12.0/24"
    nat_gw_subnet     = "10.0.11.0/24"
    availability_zone = "us-east-2a"
    tag               = "private_subnet_1"
    }, {
    cidr_block        = "10.0.22.0/24"
    nat_gw_subnet     = "10.0.21.0/24"
    availability_zone = "us-east-2b"
    tag               = "private_subnet_2"
  }]
}
