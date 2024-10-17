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
    tag        = "task_3_vpc"
  }
}

variable "igw" {
  type = object({
    tag = string
  })
  default = {
    tag = "task_3_igw"
  }
}

variable "public_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tag               = string
  }))
  default = [{
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    tag               = "task_3_public_subnet_1"
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
    cidr_block        = "10.0.2.0/24"
    nat_gw_subnet     = "10.0.1.0/24"
    availability_zone = "us-east-2a"
    tag               = "task_3_private_subnet_1"
  }]
}
