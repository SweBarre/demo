resource "rancher2_cluster" "k3s-cluster" {
  count = var.k3s_cluster_count
  name = format("%s-%02s", var.prefix, count.index +1)
  description = "k3s imported fleet-demo cluster"
  labels = var.k3s_cluster_labels[count.index]
}


resource "ssh_resource" "register_k3s" {
  count = var.k3s_cluster_count
  depends_on = [rancher2_cluster.k3s-cluster, ssh_resource.install_k3s]
  host = aws_instance.k3s_instance[count.index].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "curl --insecure sfL ${rancher2_cluster.k3s-cluster[count.index].cluster_registration_token.0.manifest_url} | sudo /usr/local/bin/kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml apply -f -"
  ]
}

resource "rancher2_cluster_sync" "k3s-cluster" {
  depends_on = [ssh_resource.register_k3s]
  count = var.k3s_cluster_count
  cluster_id = rancher2_cluster.k3s-cluster[count.index].id
  wait_catalogs = true
  state_confirm = 2
}
