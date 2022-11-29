module "elastic" {
  source = "../modules/vm/"

  vm_name           = "elastic"
  vm_memory         = 4096
  vm_cpu            = 2
  pool_name         = libvirt_pool.cluster.name
  network_name      = libvirt_network.jamf.name
  cloudinit_disk_id = libvirt_cloudinit_disk.commoninit.id
  base_image_id     = libvirt_volume.debian11-base-qcow2.id
}

module "test_app" {
  source = "../modules/vm/"

  vm_memory         = 2048
  vm_cpu            = 1
  vm_name           = "test_app"
  pool_name         = libvirt_pool.cluster.name
  network_name      = libvirt_network.jamf.name
  cloudinit_disk_id = libvirt_cloudinit_disk.commoninit_app.id
  base_image_id     = libvirt_volume.debian11-base-qcow2.id
}

output "elastic_ip" {
  value = module.elastic.ip
}

output "test_ip" {
  value = module.test_app.ip
}
