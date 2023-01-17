resource "helm_release" "rancher_server" {
  depends_on = [
    helm_release.cert_manager,
  ]

  name             = "rancher"
  chart            = "https://charts.rancher.com/server-charts/prime/rancher-${var.rancher_version}.tgz"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = local.rancher_hostname
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin"
  }
}

resource "rancher2_bootstrap" "admin" {

  depends_on = [helm_release.rancher_server]

  provider = rancher2.bootstrap

  password  = var.rancher_server_admin_password
  telemetry = true
}

locals {
  rancher_hostname = join(".", ["rancher", aws_instance.rke2_master_instance[0].public_ip, "sslip.io"])
}
