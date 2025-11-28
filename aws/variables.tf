variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "capstone"
}

variable "key_name" {
  type    = string
  default = "netrika-key"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/netrika-key.pub"
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

