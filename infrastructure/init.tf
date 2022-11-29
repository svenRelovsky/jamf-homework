# Cloud-init datas and disks
# ELK (Main node) data section
data "template_file" "bootstrap_conf" {
  template = file("${path.module}/files/bootstrap.sh.tpl")
  vars = {
    is_elastic_node = true
  }
}

data "template_file" "puppet_manifest" {
  template = file("${path.module}/files/config.pp")
}

data "template_file" "logstash_conf" {
  template = file("${path.module}/files/logstash_conf")

  vars = {
    elastic_address = "elastic.jamf.local"
  }
}

data "template_file" "common_init" {
  template = file("${path.module}/files/cloud_init.cfg")

  vars = {
    logstash_conf   = data.template_file.logstash_conf.rendered
    puppet_manifest = data.template_file.puppet_manifest.rendered
    bootstrap_conf  = data.template_file.bootstrap_conf.rendered
  }
}

# APP section
data "template_file" "bootstrap_conf_app" {
  template = file("${path.module}/files/bootstrap.sh.tpl")
  vars = {
    is_elastic_node = false
  }
}

data "template_file" "puppet_manifest_app" {
  template = file("${path.module}/files/config_app.pp")
}

data "template_file" "common_init_app" {
  template = file("${path.module}/files/cloud_init.cfg")

  vars = {
    logstash_conf   = data.template_file.logstash_conf.rendered
    puppet_manifest = data.template_file.puppet_manifest_app.rendered
    bootstrap_conf  = data.template_file.bootstrap_conf_app.rendered
  }
}

# Resource ELK
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  pool      = libvirt_pool.cluster.name
  user_data = data.template_file.common_init.rendered
}

# Resource ELK
resource "libvirt_cloudinit_disk" "commoninit_app" {
  name      = "commoninit_app.iso"
  pool      = libvirt_pool.cluster.name
  user_data = data.template_file.common_init_app.rendered
}
