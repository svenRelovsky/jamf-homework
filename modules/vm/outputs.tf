output "ip" {
  value = libvirt_domain.this.network_interface.0.addresses.0
}
