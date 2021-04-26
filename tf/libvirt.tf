# libvirt.tf
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.3"
    }
  }
}

provider "libvirt" {
 uri = "qemu:///system"
}

resource "libvirt_pool" "ubuntu" {
 name = "ubuntu-pool"
 type = "dir"
 path = "/home/mrfubar/vm/ubuntu"
}

# create image
resource "libvirt_volume" "image-qcow2" {
 name = "ubuntu-amd64.qcow2"
 pool = libvirt_pool.ubuntu.name
 source = "/home/mrfubar/Downloads/focal-server-cloudimg-amd64.img"
 format = "qcow2"
}

# add cloudinit disk to pool
resource "libvirt_cloudinit_disk" "commoninit" {
 name = "commoninit.iso"
 pool = libvirt_pool.ubuntu.name
 user_data = data.template_file.user_data.rendered
}

# read the configuration
data "template_file" "user_data" {
 template = file("${path.module}/cloud_init.cfg")
}

# Define KVM domain to create
resource "libvirt_domain" "test-domain" {
 # name should be unique!
 name = "test-vm-ubuntu"
 memory = "2048"
 vcpu = 2
 # add the cloud init disk to share user data
 cloudinit = libvirt_cloudinit_disk.commoninit.id
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
  volume_id = libvirt_volume.image-qcow2.id
 }
 graphics {
  type = "spice"
  listen_type = "address"
  autoport = true
 }
}

# Output Server IP
output "ip" {
  value = "${libvirt_domain.test_domain.network_interface.0.addresses.0}"
}
