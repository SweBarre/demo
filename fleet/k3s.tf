resource "ssh_resource" "install_k3s" {
  count = var.k3s_cluster_count
  host = aws_instance.k3s_instance[count.index].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION='${var.k3s_version}' INSTALL_K3S_EXEC='--tls-san ${aws_instance.k3s_instance[count.index].public_ip}' sh -"
  ]
}


resource "ssh_resource" "k3s_kubeconf" {
  depends_on = [ssh_resource.install_k3s]
  count = var.k3s_cluster_count
  host = aws_instance.k3s_instance[count.index].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo cat /etc/rancher/k3s/k3s.yaml | awk '{gsub(/127.0.0.1/,\"${aws_instance.k3s_instance[count.index].public_ip}\");}1'"
  ]
}

resource "local_sensitive_file" "local_kubeconf" {
  count = var.k3s_cluster_count
  filename = format("%s/kubeconf_%02s", path.module, count.index +1)
  content = ssh_resource.k3s_kubeconf[count.index].result
  file_permission = "0600"
}
