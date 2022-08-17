variable prefix {
  type = string
  description = "Prefix added to all AWS resources (also used as cluster name)"
  default = "rms-demo"
}

variable "aws_master_instance_type" {
  type = string
  description = "Type of EC2 Instance to use"
  default = "t3.large"
}

variable "aws_access_key" {
  type = string
  description = "AWS Access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS Secret key"
}

variable "aws_region" {
  type = string
  description = "AWS Region to deploy to"
  default = "eu-north-1"
}


variable rke2_master_node_count {
  type = number
  description = "Number of master nodes in cluster"
  default = 1
}


variable "rke2_version" {
  type = string
  description = "rke2 Kubernetes version"
  default = "v1.22.10-rc2+rke2r1"
}

locals {
  node_username = "ec2-user"
}
