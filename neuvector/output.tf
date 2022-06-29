output "rancher_url" {
  value = var.rancher_api_url
}

output "master_node_ip" {
  value = {
    for instance in aws_instance.rke2_master_instance:
     instance.tags.Name => instance.public_ip
  }
}

output "worker_node_ip" {
  value = {
    for instance in aws_instance.rke2_worker_instance:
     instance.tags.Name => instance.public_ip
  }
}

output "neuvector_url" {
  value = {
    for instance in aws_instance.rke2_master_instance:
    instance.tags.Name => "https://${instance.public_ip}:${ssh_resource.nv-svc-nodeport.result}"
  }
}

output "guestbook_url" {
  value = "http://guestbook.${aws_instance.rke2_master_instance[0].public_ip}.sslip.io"
}
