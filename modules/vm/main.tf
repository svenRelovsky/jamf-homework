# Move to a module

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.0"
    }
  }
}

resource "libvirt_volume" "this" {
  name           = var.vm_name
  pool           = var.pool_name
  size           = var.disk_size
  base_volume_id = var.base_image_id
  format         = "qcow2"
}

resource "libvirt_domain" "this" {
  name   = var.vm_name
  memory = var.vm_memory
  vcpu   = var.vm_cpu

  network_interface {
    network_name = var.network_name
    wait_for_lease = true  # otherwise it fails on output until a refresh is done
  }

  cloudinit = var.cloudinit_disk_id

  disk {
    volume_id = libvirt_volume.this.id
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

}
