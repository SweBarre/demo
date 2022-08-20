<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.17.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.5.1 |
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
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.k3s_instance](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/instance) | resource |
| [aws_key_pair.fleetdemo_key_pair](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/key_pair) | resource |
| [aws_security_group.fleetdemo_sg_allowall](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/resources/security_group) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key_openssh](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/2.2.3/docs/resources/sensitive_file) | resource |
| [tls_private_key.ssh_key](https://registry.terraform.io/providers/hashicorp/tls/3.4.0/docs/resources/private_key) | resource |
| [aws_ami.hostos](https://registry.terraform.io/providers/hashicorp/aws/4.17.0/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS Access key | `string` | n/a | yes |
| <a name="input_aws_instance_type"></a> [aws\_instance\_type](#input\_aws\_instance\_type) | Type of EC2 Instance to use | `string` | `"t3.micro"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region to deploy to | `string` | `"eu-north-1"` | no |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS Secret key | `string` | n/a | yes |
| <a name="input_k3s_cluster_count"></a> [k3s\_cluster\_count](#input\_k3s\_cluster\_count) | Number of single node k3s clusters to deploy | `number` | `3` | no |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | k3s version to deploy | `string` | `"v1.22.10-rc2+rke2r1"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix added to all AWS resources (also used as cluster name) | `string` | `"fleet-demo"` | no |
| <a name="input_rancher_access_key"></a> [rancher\_access\_key](#input\_rancher\_access\_key) | Access key to rancher management server | `string` | n/a | yes |
| <a name="input_rancher_api_url"></a> [rancher\_api\_url](#input\_rancher\_api\_url) | URL to where cluster should register | `string` | `"https://demo-hosted.rancher.cloud"` | no |
| <a name="input_rancher_insecure"></a> [rancher\_insecure](#input\_rancher\_insecure) | Allow insecure connection to Rancher. Mandatory if self signed tls and not ca\_certs provided. | `bool` | `false` | no |
| <a name="input_rancher_secret_key"></a> [rancher\_secret\_key](#input\_rancher\_secret\_key) | Secret key to rancher management server | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->