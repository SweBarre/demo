resource "rancher2_app_v2" "neuvector" {
  depends_on = [rancher2_cluster_sync.catalog-repo-sync]
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
  apisvc:
    type: ClusterIP
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
manager:
  ingress:
    enabled: true
    host: ${local.neuvector_hostname}
    tls: true
    annotations:
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
EOF
}

locals {
  neuvector_hostname = join(".", ["neuvector", aws_instance.rke2_master_instance[0].public_ip, "sslip.io"])
}
