resource "ssh_resource" "rke2_master_config_dir" {
  count = var.rke2_master_node_count
  host = aws_instance.rke2_master_instance[count.index].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo mkdir -p /etc/rancher/rke2",
    "sudo chmod 777 /etc/rancher/rke2"
  ]
}

resource "ssh_resource" "rke2_first_master_config" {
  depends_on = [ssh_resource.rke2_master_config_dir]
  user = local.node_username
  host = aws_instance.rke2_master_instance[0].public_ip
  private_key = tls_private_key.ssh_key.private_key_pem
  file {
    content     = <<EOT
token: ${var.rke2_cluster_token}
tls-san:
  - ${aws_instance.rke2_master_instance[0].public_ip}
  - ${aws_instance.rke2_master_instance[0].private_ip}
node-external-ip: ${aws_instance.rke2_master_instance[0].public_ip}
node-ip: ${aws_instance.rke2_master_instance[0].private_ip}
EOT
    destination = "/etc/rancher/rke2/config.yaml"
    permissions = "0644"
  }
}

resource "ssh_resource" "rke2_master_config" {
  count = var.rke2_master_node_count - 1
  depends_on = [ssh_resource.rke2_master_config_dir]
  user = local.node_username
  host = aws_instance.rke2_master_instance[count.index+1].public_ip
  private_key = tls_private_key.ssh_key.private_key_pem
  file {
    content     = <<EOT
server: https://${aws_instance.rke2_master_instance[0].private_ip}:9345
token: ${var.rke2_cluster_token}
tls-san:
  - ${aws_instance.rke2_master_instance[count.index+1].public_ip}
  - ${aws_instance.rke2_master_instance[count.index+1].private_ip}
node-external-ip: ${aws_instance.rke2_master_instance[count.index+1].public_ip}
node-ip: ${aws_instance.rke2_master_instance[count.index+1].private_ip}
EOT
    destination = "/etc/rancher/rke2/config.yaml"
    permissions = "0644"
  }
}

resource "ssh_resource" "rke2_worker_config_dir" {
  count = var.rke2_worker_node_count
  host = aws_instance.rke2_worker_instance[count.index].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo mkdir -p /etc/rancher/rke2",
    "sudo chmod 777 /etc/rancher/rke2"
  ]
}

resource "ssh_resource" "rke2_worker_config" {
  count = var.rke2_worker_node_count
  depends_on = [ssh_resource.rke2_worker_config_dir]
  user = local.node_username
  host = aws_instance.rke2_worker_instance[count.index].public_ip
  private_key = tls_private_key.ssh_key.private_key_pem
  file {
    content     = <<EOT
server: https://${aws_instance.rke2_master_instance[0].private_ip}:9345
token: ${var.rke2_cluster_token}
EOT
    destination = "/etc/rancher/rke2/config.yaml"
    permissions = "0644"
  }
}

resource "ssh_resource" "install_rke2_first_master" {
  depends_on = [ssh_resource.rke2_first_master_config]
  host = aws_instance.rke2_master_instance[0].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo bash -c 'curl https://get.rke2.io | INSTALL_RKE2_VERSION=${var.rke2_version} sh -'",
    "sudo systemctl enable rke2-server --now",
    "sleep 2m",
    "sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml -n kube-system rollout status daemonset rke2-ingress-nginx-controller"
  ]
}


resource "ssh_resource" "install_rke2_master" {
  depends_on = [ssh_resource.install_rke2_first_master, ssh_resource.rke2_master_config]
  count = var.rke2_master_node_count - 1
  host = aws_instance.rke2_master_instance[count.index+1].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo bash -c 'curl https://get.rke2.io | INSTALL_RKE2_VERSION=${var.rke2_version} sh -'",
    "sleep ${count.index}m",
    "sudo systemctl enable rke2-server --now"
  ]
}

resource "ssh_resource" "install_rke2_worker" {
  depends_on = [ssh_resource.install_rke2_first_master, ssh_resource.install_rke2_master, ssh_resource.rke2_worker_config]
  count = var.rke2_worker_node_count
  host = aws_instance.rke2_worker_instance[count.index].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo bash -c 'curl https://get.rke2.io | INSTALL_RKE2_TYPE=\"agent\" INSTALL_RKE2_VERSION=${var.rke2_version} sh -'",
    "sleep ${count.index}m",
    "sudo systemctl enable rke2-agent --now"
  ]
}

resource "ssh_resource" "rke2_kubeconf" {
  depends_on = [ssh_resource.install_rke2_first_master]
  host = aws_instance.rke2_master_instance[0].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo cat /etc/rancher/rke2/rke2.yaml | awk '{gsub(/127.0.0.1/,\"${aws_instance.rke2_master_instance[0].public_ip}\");}1'"
  ]
}

resource "local_sensitive_file" "local_kubeconf" {
  filename = "${path.module}/kubeconf"
  content = ssh_resource.rke2_kubeconf.result
  file_permission = "0600"
}
