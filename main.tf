data "vsphere_datacenter" "datacenter" {
  name = "${var.dcname}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.dcstore_name}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_clustername
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "default" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = var.esxi_host_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vnet_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template_from_ovf" {
  name          = var.vm_template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "template_file" "cloud-init" {
  template = file("./templates/userdata.yaml") 
  vars = {
    vm_user_name = var.vm_user_name
    vm_user_displayname = var.vm_user_displayname
    vm_user_password  = var.vm_user_password
    vm_user_ssh_key   = var.vm_user_ssh_key
    ansible_repo_url  = var.ansible_repo_url
    ansible_playbook  = var.ansible_playbook
    vm_ssh_port       = var.vm_ssh_port
    ansible_repo_name = var.ansible_repo_name
    esxi_host_name    = var.esxi_host_name
    vsphere_host_ip   = var.vsphere_host_ip
    vnc_password      = var.vnc_password
  }

  #}
  
}
data "template_cloudinit_config" "cloud-init" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloud-init.rendered
  }
}

 
resource "vsphere_virtual_machine" "vmFromLocalOvf"  {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  host_system_id   = data.vsphere_host.host.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.vm_cpu_count
  memory           = var.vm_ram_size
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
 
  }
  disk {
    label = "disk0"
    size  = var.vm_disk_size
  }
    cdrom {
    client_device = true
  }
  clone {
     template_uuid = data.vsphere_virtual_machine.template_from_ovf.id

  }
 
  vapp {
  properties = {
                     
        }
  }
  extra_config = {
     "guestinfo.userdata" = base64encode(data.template_file.cloud-init.rendered)
     "guestinfo.userdata.encoding" = "base64"
     "guestinfo.metadata" = base64encode(file("${path.module}/templates/metadata.yaml"))
     "guestinfo.metadata.encoding" = "base64" 
  }  

}

#out