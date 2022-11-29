# A pool for all cluster volumes
resource "libvirt_pool" "cluster" {
  name = "cluster"
  type = "dir"
  # path = "/var/local/libvirt/cluster"
  # path = "/tmp/cluster"
  path = "/home/kotyogo/virts"
}

resource "libvirt_volume" "debian11-base-qcow2" {
  name   = "debian11.qcow2"
  pool   = libvirt_pool.cluster.name
  source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.qcow2"
  format = "qcow2"
}
