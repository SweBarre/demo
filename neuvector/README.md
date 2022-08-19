# NeuVector Demo environment

This will create an RKE2 cluster running on EC2 with an wide open security group and local created id\_ed25519 ssh keys and register the cluster as a down stream cluster on a specified rancher management server (default https://demo-hosted.rancher.cloud/)
You could also deploy a rancher management server using [this terrarom script](../rancher/)

It will also create a kubeconf in the directory pointing to the first rke2 master node

## Getting started

Start by cloning the repository and copy hte tfvars example file
```
git clone https://github.com/SweBarre/demo.git
cd demo/neuvector
cp terraform.tfvars.example terraform.tfvars
```
There are five mandatory variables that needs to be congifured in the `terraform.tfvars` file:
- `aws_access_key` and `aws_secret_key` to access to your AWS account
- `rancher_access_key` and `rancher_secret_key` to access your Rancher Management Server, create them by clicking on your profile in Rancher and select "Accounts & API Keys"
- `neuvector_admin_password`, a strong and secure password for logging into NeuVector without using the Rancher SSO integration.

## Demo examples
- [Mitigate the SACK Panic DDoS Attack](demos/SACK\_DDOS.md)
- [Data Loss Prevention - VISA Credit card number](demos/DLP\_VISA\_CREDITCARD.md)


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
| <a name="provider_rancher2"></a> [rancher2](#provider\_rancher2) | 1.24.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 1.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.rke2_master_instance](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/instance) | resource |
| [aws_instance.rke2_worker_instance](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/instance) | resource |
| [aws_key_pair.nvdemo_key_pair](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/key_pair) | resource |
| [aws_security_group.nvdemo_sg_allowall](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/security_group) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/file) | resource |
| [local_sensitive_file.local_kubeconf](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.ssh_private_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [rancher2_app_v2.guestbook](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/app_v2) | resource |
| [rancher2_app_v2.kali-linux](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/app_v2) | resource |
| [rancher2_app_v2.neuvector](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/app_v2) | resource |
| [rancher2_catalog_v2.demo-apps](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/catalog_v2) | resource |
| [rancher2_cluster.rancher-cluster](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/cluster) | resource |
| [rancher2_cluster_sync.catalog-repo-sync](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/cluster_sync) | resource |
| [rancher2_cluster_sync.rancher-cluster](https://registry.terraform.io/providers/rancher/rancher2/1.24.0/docs/resources/cluster_sync) | resource |
| [random_password.cluster-token](https://registry.terraform.io/providers/hashicorp/random/3.3.2/docs/resources/password) | resource |
| [ssh_resource.install_rke2_first_master](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.install_rke2_master](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.install_rke2_worker](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.register_rke](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_first_master_config](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_kubeconf](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_master_config](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_master_config_dir](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_worker_config](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [ssh_resource.rke2_worker_config_dir](https://registry.terraform.io/providers/loafoe/ssh/1.2.0/docs/resources/resource) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |
| [aws_ami.hostos](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access key | `string` | n/a | yes |
| <a name="input_aws_master_instance_type"></a> [aws\_master\_instance\_type](#input\_aws\_master\_instance\_type) | Type of EC2 Instance to use | `string` | `"t3.xlarge"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to deploy to | `string` | `"eu-north-1"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS Secret key | `string` | n/a | yes |
| <a name="input_aws_worker_instance_type"></a> [aws\_worker\_instance\_type](#input\_aws\_worker\_instance\_type) | Type of EC2 Instance to use | `string` | `"t3.xlarge"` | no |
| <a name="input_install_guestbook"></a> [install\_guestbook](#input\_install\_guestbook) | Install guestbook demo app into default namespace | `bool` | `false` | no |
| <a name="input_install_kali"></a> [install\_kali](#input\_install\_kali) | Install kali-linux instance into default namespace | `bool` | `false` | no |
| <a name="input_neuvector_admin_password"></a> [neuvector\_admin\_password](#input\_neuvector\_admin\_password) | The password for the default admin user login | `string` | n/a | yes |
| <a name="input_neuvector_chart_version"></a> [neuvector\_chart\_version](#input\_neuvector\_chart\_version) | version of NeuVector chart to install | `string` | `"100.0.0+up2.2.0"` | no |
| <a name="input_neuvector_controller_replicas"></a> [neuvector\_controller\_replicas](#input\_neuvector\_controller\_replicas) | Number of NeuVector controllers to deploy | `number` | `1` | no |
| <a name="input_neuvector_scanners_replicas"></a> [neuvector\_scanners\_replicas](#input\_neuvector\_scanners\_replicas) | Number of NeuVector scanners to deploy | `number` | `1` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix added to all AWS resources (also used as cluster name) | `string` | `"nv-demo"` | no |
| <a name="input_rancher_access_key"></a> [rancher\_access\_key](#input\_rancher\_access\_key) | Access key to rancher management server | `string` | n/a | yes |
| <a name="input_rancher_api_url"></a> [rancher\_api\_url](#input\_rancher\_api\_url) | URL to where cluster should register | `string` | `"https://demo-hosted.rancher.cloud"` | no |
| <a name="input_rancher_secret_key"></a> [rancher\_secret\_key](#input\_rancher\_secret\_key) | Secret key to rancher management server | `string` | n/a | yes |
| <a name="input_rke2_master_node_count"></a> [rke2\_master\_node\_count](#input\_rke2\_master\_node\_count) | Number of master nodes in cluster | `number` | `1` | no |
| <a name="input_rke2_version"></a> [rke2\_version](#input\_rke2\_version) | rke2 Kubernetes version | `string` | `"v1.22.10-rc2+rke2r1"` | no |
| <a name="input_rke2_worker_node_count"></a> [rke2\_worker\_node\_count](#input\_rke2\_worker\_node\_count) | Number of worker nodes in cluster | `number` | `0` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_guestbook_url"></a> [guestbook\_url](#output\_guestbook\_url) | URL to Guestbook demo app if `var.install_guestbook`is set to `true` |
| <a name="output_master_node_ssh"></a> [master\_node\_ssh](#output\_master\_node\_ssh) | SSH commands to login to master nodes |
| <a name="output_neuvector_url"></a> [neuvector\_url](#output\_neuvector\_url) | The URL to NeuVector GUI (login without rancher SSO) |
| <a name="output_rancher_url"></a> [rancher\_url](#output\_rancher\_url) | The URL to the RMS as set in `var.rancher_api_url` |
| <a name="output_set_kubeconfig"></a> [set\_kubeconfig](#output\_set\_kubeconfig) | Prints out `export KUBECONFIG=$(pwd)/kubeconf`for easy copy/paste access |
| <a name="output_worker_node_ssh"></a> [worker\_node\_ssh](#output\_worker\_node\_ssh) | SSH commands to login to worker nodes |
<!-- END_TF_DOCS -->
