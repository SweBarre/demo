output "rancher_url" {
  description = "The URL to the Rancher UI"
  value = "https://${local.rancher_hostname}"
}

output "set_kubeconfig" {
  description = "Prints out `export KUBECONFIG=$(pwd)/kubeconf`for easy copy/paste access"
  value = "export KUBECONFIG=$(pwd)/kubeconf"
}
