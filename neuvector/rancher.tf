resource "rancher2_cluster" "rancher-cluster" {
  name = "${var.prefix}-cluster"
  description = "RKE2 imported nv-demo cluster"
}

resource "ssh_resource" "register_rke" {
  depends_on = [rancher2_cluster.rancher-cluster, ssh_resource.install_rke2_first_master, ssh_resource.install_rke2_master]
  host = aws_instance.rke2_master_instance[0].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml apply -f ${rancher2_cluster.rancher-cluster.cluster_registration_token.0.manifest_url}"
  ]
}

resource "rancher2_cluster_sync" "rancher-cluster" {
  depends_on = [ssh_resource.register_rke]
  cluster_id = rancher2_cluster.rancher-cluster.id
  wait_catalogs = true
  state_confirm = 3
}
