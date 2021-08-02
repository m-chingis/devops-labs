########## Item: 01 ################
# create pool for: node-cp1
resource "libvirt_pool" "node-cp1" {
  name = "pool-node-cp1"
  type = "dir"
  path = "${var.vm_location}/node-cp1"
}

# create image for: node-cp1
resource "libvirt_volume" "node-cp1-image-qcow2" {
  name = "node-cp1-amd64.qcow2"
  pool = libvirt_pool.node-cp1.name
  source = var.ubuntu_cloudimg_amd64_path 
  format = "qcow2"
}

# add cloudinit disk to pool for: node-cp1
resource "libvirt_cloudinit_disk" "cloudinit-node-cp1" {
  name = "cloudinit-node-cp1.iso"
  pool = libvirt_pool.node-cp1.name
  user_data = data.template_file.user_data-node-cp1.rendered
}

# read the configuration for: node-cp1
data "template_file" "user_data-node-cp1" {
  template = file("${path.module}/cloud_init-node-cp1.cfg")
}

# Define KVM domain to create for: vm-node-cp1
resource "libvirt_domain" "vm-cp1" {
  # name should be unique!
  name = "vm-node-cp1"
  memory = "1600"
  vcpu = 1
  # add the cloud init disk to share user data
  cloudinit = libvirt_cloudinit_disk.cloudinit-node-cp1.id
  # set to default libvirt network
  network_interface {
    network_name = "default"
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
  disk {
    volume_id = libvirt_volume.node-cp1-image-qcow2.id
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

########## Item: 02 ################
# create pool for: node-w01
resource "libvirt_pool" "node-w01" {
  name = "pool-node-w01"
  type = "dir"
  path = "${var.vm_location}/node-w01"
}

# create image for: node-w01
resource "libvirt_volume" "node-w01-image-qcow2" {
  name = "node-w01-amd64.qcow2"
  pool = libvirt_pool.node-w01.name
  source = var.ubuntu_cloudimg_amd64_path
  format = "qcow2"
}

# add cloudinit disk to pool for: node-w01
resource "libvirt_cloudinit_disk" "cloudinit-node-w01" {
  name = "cloudinit-node-w01.iso"
  pool = libvirt_pool.node-w01.name
  user_data = data.template_file.user_data-node-w01.rendered
}

# read the configuration for: node-w01
data "template_file" "user_data-node-w01" {
  template = file("${path.module}/cloud_init-node-w01.cfg")
}

# Define KVM domain to create for: node-w01
resource "libvirt_domain" "vm-node-w01" {
  # name should be unique!
  name = "vm-node-w01"
  memory = "1100"
  vcpu = 1
  # add the cloud init disk to share user data
  cloudinit = libvirt_cloudinit_disk.cloudinit-node-w01.id
  # set to default libvirt network
  network_interface {
    network_name = "default"
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
  disk {
    volume_id = libvirt_volume.node-w01-image-qcow2.id
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}


########## Item: 03 ################
# create pool for: node-w02
resource "libvirt_pool" "node-w02" {
  name = "pool-node-w02"
  type = "dir"
  path = "${var.vm_location}/node-w02"
}

# create image for: node-w02
resource "libvirt_volume" "node-w02-image-qcow2" {
  name = "node-w02-amd64.qcow2"
  pool = libvirt_pool.node-w02.name
  source = var.ubuntu_cloudimg_amd64_path
  format = "qcow2"
}

# add cloudinit disk to pool for: node-w02
resource "libvirt_cloudinit_disk" "cloudinit-node-w02" {
  name = "cloudinit-node-w02.iso"
  pool = libvirt_pool.node-w02.name
  user_data = data.template_file.user_data-node-w02.rendered
}

# read the configuration for: node-w02
data "template_file" "user_data-node-w02" {
  template = file("${path.module}/cloud_init-node-w02.cfg")
}

# Define KVM domain to create for: node-w02
resource "libvirt_domain" "vm-node-w02" {
  # name should be unique!
  name = "vm-node-w02"
  memory = "1100"
  vcpu = 1
  # add the cloud init disk to share user data
  cloudinit = libvirt_cloudinit_disk.cloudinit-node-w02.id
  # set to default libvirt network
  network_interface {
    network_name = "default"
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
  disk {
    volume_id = libvirt_volume.node-w02-image-qcow2.id
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}


########## Item: 04 ################
# create pool for: node-w03
resource "libvirt_pool" "node-w03" {
  name = "pool-node-w03"
  type = "dir"
  path = "${var.vm_location}/node-w03"
}

# create image for: node-w03
resource "libvirt_volume" "node-w03-image-qcow2" {
  name = "node-w03-amd64.qcow2"
  pool = libvirt_pool.node-w03.name
  source = var.ubuntu_cloudimg_amd64_path
  format = "qcow2"
}

# add cloudinit disk to pool for: node-w03
resource "libvirt_cloudinit_disk" "cloudinit-node-w03" {
  name = "cloudinit-node-w03.iso"
  pool = libvirt_pool.node-w03.name
  user_data = data.template_file.user_data-node-w03.rendered
}

# read the configuration for: node-w03
data "template_file" "user_data-node-w03" {
  template = file("${path.module}/cloud_init-node-w03.cfg")
}

# Define KVM domain to create for: node-w03
resource "libvirt_domain" "vm-node-w03" {
  # name should be unique!
  name = "vm-node-w03"
  memory = "1100"
  vcpu = 1
  # add the cloud init disk to share user data
  cloudinit = libvirt_cloudinit_disk.cloudinit-node-w03.id
  # set to default libvirt network
  network_interface {
    network_name = "default"
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
  disk {
    volume_id = libvirt_volume.node-w03-image-qcow2.id
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}
