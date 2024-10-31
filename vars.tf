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
    tag        = "task_4_vpc"
  }
}

variable "igw" {
  type = object({
    tag = string
  })
  default = {
    tag = "task_4_igw"
  }
}
