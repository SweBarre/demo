variable prefix {
  type = string
  description = "Prefix added to all AWS resources (also used as cluster name)"
  default = "nv-demo"
}

variable "aws_master_instance_type" {
  type = string
  description = "Type of EC2 Instance to use"
  default = "t3.xlarge"
}

variable "aws_worker_instance_type" {
  type = string
  description = "Type of EC2 Instance to use"
  default = "t3.xlarge"
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

variable "rancher_api_url" {
  type = string
  description = "URL to where cluster should register"
  default = "https://demo-hosted.rancher.cloud"
}

variable "rancher_api_insecure" {
  type = bool
  description = "The Rancher API is using a self signed certificate"
  default = false
}

variable "rancher_access_key" {
  type = string
  description = "Access key to rancher management server"
}

variable "rancher_secret_key" {
  type = string
  description = "Secret key to rancher management server"
}

variable rke2_master_node_count {
  type = number
  description = "Number of master nodes in cluster"
  default = 1
}

variable rke2_worker_node_count {
  type = number
  description = "Number of worker nodes in cluster"
  default = 0
}

variable "rke2_version" {
  type = string
  description = "rke2 Kubernetes version"
  default = "v1.24.9+rke2r1"
}

variable "neuvector_admin_password" {
  type = string
  description = "The password for the default admin user login. Eight(8) characters or more, atleast 1 lowercase, 1 uppercase and 1 number"
}

variable "neuvector_chart_version" {
  type = string
  description = "version of NeuVector chart to install"
  default = "102.0.0+up2.4.2"
}

variable "neuvector_controller_replicas" {
  type = number
  description = "Number of NeuVector controllers to deploy"
  default = 1
}

variable "neuvector_scanners_replicas" {
  type = number
  description = "Number of NeuVector scanners to deploy"
  default = 1
}

variable "install_guestbook" {
  type = bool
  description = "Install guestbook demo app into default namespace"
  default = false
}

variable "install_kali" {
  type = bool
  description = "Install kali-linux instance into default namespace"
  default = false
}

variable "install_orders" {
  type = bool
  description = "Install orders app for struts RCE demo, it also spins up a client VM to do the attacks from"
  default = false
}

variable "aws_client_instance_type" {
  type = string
  description = "Type of EC2 Instance to use"
  default = "t3.nano"
}


locals {
  node_username = "ec2-user"
}
