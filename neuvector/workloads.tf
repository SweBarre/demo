resource "rancher2_app_v2" "guestbook" {
  count = var.install_guestbook ? 1 : 0
  depends_on = [rancher2_cluster_sync.catalog-repo-sync]
  cluster_id = rancher2_cluster.rancher-cluster.id
  name = "guestbook"
  namespace = "default"
  repo_name = "demo-apps"
  chart_name = "guestbook"
  values = <<EOF
ingress:
  enabled: true
  host: "guestbook.${aws_instance.rke2_master_instance[0].public_ip}.sslip.io"
EOF
}

resource "rancher2_app_v2" "kali-linux" {
  count = var.install_kali ? 1 : 0
  depends_on = [rancher2_cluster_sync.catalog-repo-sync]
  cluster_id = rancher2_cluster.rancher-cluster.id
  name = "kali"
  namespace = "default"
  repo_name = "demo-apps"
  chart_name = "kali-linux"
}
