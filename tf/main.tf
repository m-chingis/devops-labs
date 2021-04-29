# create pool
resource "libvirt_pool" "ubuntu" {
  name = "ubuntu-pool"
  type = "dir"
  path = "${var.vm_location}/ubuntu"
}

# create image
resource "libvirt_volume" "image-qcow2" {
  name = "ubuntu-amd64.qcow2"
  pool = libvirt_pool.ubuntu.name
  source = var.ubuntu_cloudimg_amd64_path 
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
resource "libvirt_domain" "ubuntu-vm1" {
  # name should be unique!
  name = "ubuntu-vm1"
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
