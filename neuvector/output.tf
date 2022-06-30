output "rancher_url" {
  description = "The URL to the RMS as set in `var.rancher_api_url`"
  value = var.rancher_api_url
}

output "master_node_ip" {
  description = "List of IP-addresses for the master nodes"
  value = {
    for instance in aws_instance.rke2_master_instance:
     instance.tags.Name => instance.public_ip
  }
}

output "worker_node_ip" {
  description = "List of IP-addresses for the worker nodes"
  value = {
    for instance in aws_instance.rke2_worker_instance:
     instance.tags.Name => instance.public_ip
  }
}

output "neuvector_url" {
  description = "URL to access NeuVector on master node 0 IP and NodePort"
  value = {
    for instance in aws_instance.rke2_master_instance:
    instance.tags.Name => "https://${instance.public_ip}:${ssh_resource.nv-svc-nodeport.result}"
  }
}

output "guestbook_url" {
  description = "URL to Guestbook demo app if `var.install_guestbook`is set to `true`"
  value = var.install_guestbook  ? "http://guestbook.${aws_instance.rke2_master_instance[0].public_ip}.sslip.io" : null
}

output "set_kubeconfig" {
  description = "Prints out `export KUBECONFIG=$(pwd)/kubeconf`for easy copy/paste access"
  value = "export KUBECONFIG=$(pwd)/kubeconf"
}
