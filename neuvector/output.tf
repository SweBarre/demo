output "rancher_url" {
  description = "The URL to the RMS as set in `var.rancher_api_url`"
  value = var.rancher_api_url
}

output "master_node_ssh" {
  description = "SSH commands to login to master nodes"
  value = {
    for instance in aws_instance.rke2_master_instance:
     instance.tags.Name => format("ssh -i %s %s@%s", local_sensitive_file.ssh_private_key_openssh.filename, local.node_username, instance.public_ip)
  }
}

output "worker_node_ssh" {
  description = "SSH commands to login to worker nodes"
  value = var.rke2_worker_node_count > 0 ? {
    for instance in aws_instance.rke2_worker_instance:
     instance.tags.Name => format("ssh -i %s %s@%s", local_sensitive_file.ssh_private_key_openssh.filename, local.node_username, instance.public_ip)
  } : null
}

output "neuvector_url" {
  description = "The URL to NeuVector GUI (login without rancher SSO)"
  value = "https://${local.neuvector_hostname}"
}

output "guestbook_url" {
  description = "URL to Guestbook demo app if `var.install_guestbook`is set to `true`"
  value = var.install_guestbook  ? "http://guestbook.${aws_instance.rke2_master_instance[0].public_ip}.sslip.io" : null
}

output "set_kubeconfig" {
  description = "Prints out `export KUBECONFIG=$(pwd)/kubeconf`for easy copy/paste access"
  value = "export KUBECONFIG=$(pwd)/kubeconf"
}
