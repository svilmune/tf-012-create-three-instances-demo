output "instance_private_and_public_ips" {
  value = {
    for instance in module.CreateInstances.instances:
    instance.private_ip => instance.public_ip
  }
}