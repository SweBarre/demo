/**
  * # NeuVector Demo environment
  *
  * This will create an RKE2 cluster running on EC2 with an wide open security group and local created id_ed25519 ssh keys and register the cluster as a down stream cluster on a specified rancher management server (default https://demo-hosted.rancher.cloud/)
  * It will also create a kubeconf in the directory pointing to the first rke2 master node
  *
  * ## Getting started
  *
  * Start by cloning the repository and copy hte tfvars example file
  * ```
  * git clone https://github.com/SweBarre/demo.git
  * cd demo/neuvector
  * cp terraform.tfvars.example terraform.tfvars
  * ```
  * There are six mandatory variables that needs to be congifured in the `terraform.tfvars` file:
  * - `aws_access_key` and `aws_secret_key` to access to your AWS account
  * - `rancher_access_key` and `rancher_secret_key` to access your Rancher Management Server, create them by clicking on your profile in Rancher and select "Accounts & API Keys"
  * - `rke2_cluter_token` can be generated by typing `pwgen -1 50` in a linux terminal (just any random long string would work to be honest)
  * - `neuvector_admin_password`, a strong and secure password for logging into NeuVector without using the Rancher SSO integration.
  */
