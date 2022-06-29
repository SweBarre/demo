resource "rancher2_app_v2" "neuvector" {
  depends_on = [rancher2_cluster_sync.rancher-cluster]
  cluster_id = rancher2_cluster.rancher-cluster.id
  name = "neuvector"
  namespace = "cattle-neuvector-system"
  repo_name = "rancher-charts"
  chart_name = "neuvector"
  chart_version = var.neuvector_chart_version
  values = <<EOF
global:
  cattle:
    url: ${var.rancher_api_url}/
controller:
  replicas: ${var.neuvector_controller_replicas}
  ranchersso:
    enabled: true
  secret:
    enabled: true
    data:
      sysinitcfg.yaml:
        Cluster_Name: demo
      userinitcfg.yaml:
        users:
        - Fullname: admin
          Username: admin
          Role: admin
          Password: ${var.neuvector_admin_password}
cve:
  scanner:
    replicas: ${var.neuvector_scanners_replicas}
k3s:
  enabled: true
EOF
}

resource "ssh_resource" "nv-svc-nodeport" {
  depends_on = [rancher2_app_v2.neuvector]
  host = aws_instance.rke2_master_instance[0].public_ip
  user = local.node_username
  private_key = tls_private_key.ssh_key.private_key_pem
  commands = [
    "sudo /var/lib/rancher/rke2/bin/kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml -n cattle-neuvector-system get service neuvector-service-webui -o=jsonpath='{.spec.ports[0].nodePort}'"
  ]
}
