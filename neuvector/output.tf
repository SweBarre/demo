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
