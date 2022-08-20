output "rancher_url" {
  description = "The URL to the Rancher UI"
  value = "https://${local.rancher_hostname}"
}

output "set_kubeconfig" {
  description = "Prints out `export KUBECONFIG=$(pwd)/kubeconf`for easy copy/paste access"
  value = "export KUBECONFIG=$(pwd)/kubeconf"
}

output "admin_access_key" {
  description = "API Access Key for admin user"
  value = rancher2_bootstrap.admin.token_id
}

output "admin_access_secret" {
  description = "API Access Secret for admin user"
  sensitive = true
  value = rancher2_bootstrap.admin.token
}
