terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.0"
    }
  }
}

provider "libvirt" {
  # uri = "qemu:///system"
  # uri   = "qemu+ssh://kotyogo@192.168.0.31/system"
  uri = "qemu+ssh://kotyogo@192.168.0.31/session"
}
