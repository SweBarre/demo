variable prefix {
  type = string
  description = "Prefix added to all AWS resources (also used as cluster name)"
  default = "fleet-demo"
}

variable "aws_instance_type" {
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

variable "k3s_version" {
  type = string
  description = "k3s version to deploy"
  default = "v1.23.9+k3s1"
}

variable "k3s_cluster_labels" {
  type = list
  description = "list of cluster labels each cluster should have, lenght of list determin how many one node clusters deployed`"
  default = [
    {
      arch = "x86_64"
      location = "dc-1"
      env = "prod"
      dist = "k3s"
    },
    {
      arch = "x86_64"
      location = "dc-1"
      env = "dev"
      dist = "k3s"
    },
    {
      arch = "x86_64"
      location = "dc-2"
      env = "prod"
      dist = "k3s"
    }
  ]
}

variable "rancher_access_key" {
  type = string
  description = "Access key to rancher management server"
}

variable "rancher_secret_key" {
  type = string
  description = "Secret key to rancher management server"
}

variable "rancher_api_url" {
  type = string
  description = "URL to where cluster should register"
  default = "https://demo-hosted.rancher.cloud"
}

variable "rancher_insecure" {
  type = bool
  description = "Allow insecure connection to Rancher. Mandatory if self signed tls."
  default = false
}

locals {
  node_username = "ec2-user"
}
