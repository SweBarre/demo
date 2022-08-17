# Rancher Management Server Demo Environment

This will create an RKE2 cluster running on EC2 with an wide open security group and local created id\_ed25519 ssh keys and then install Rancher Management Server
It will also create a kubeconf in the directory pointing to the first rke2 master node

## Getting started

Start by cloning the repository and copy the tfvars example file
```
git clone https://github.com/SweBarre/demo.git
cd demo/rancher
cp terraform.tfvars.example terraform.tfvars
```
There are two mandatory variables that needs to be congifured in the terraform.tfvars file:
- `aws_access_key` and `aws_secret_key` to access to your AWS account


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.17.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.3 |
| <a name="requirement_rancher2"></a> [rancher2](#requirement\_rancher2) | 1.24.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.3.2 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | 1.2.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.17.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 1.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.rke2_master_instance](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/instance) | resource |
| [aws_key_pair.rmsdemo_key_pair](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/key_pair) | resource |
| [aws_security_group.rmsdemo_sg_allowall](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/security_group) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/file) | resource |
| [local_sensitive_file.local_kubeconf](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.ssh_private_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [random_password.cluster-token](https://registry.terraform.io/providers/hashicorp/random/3.3.2/docs/resources/password) | resource |
| [ssh_resource.install_rke2_first_master](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.install_rke2_master](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_first_master_config](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_kubeconf](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_master_config](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_master_config_dir](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |
| [aws_ami.hostos](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access key | `string` | n/a | yes |
| <a name="input_aws_master_instance_type"></a> [aws\_master\_instance\_type](#input\_aws\_master\_instance\_type) | Type of EC2 Instance to use | `string` | `"t3.large"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to deploy to | `string` | `"eu-north-1"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS Secret key | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix added to all AWS resources (also used as cluster name) | `string` | `"rms-demo"` | no |
| <a name="input_rke2_master_node_count"></a> [rke2\_master\_node\_count](#input\_rke2\_master\_node\_count) | Number of master nodes in cluster | `number` | `1` | no |
| <a name="input_rke2_version"></a> [rke2\_version](#input\_rke2\_version) | rke2 Kubernetes version | `string` | `"v1.22.10-rc2+rke2r1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
