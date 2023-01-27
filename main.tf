provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

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

data "template_file" "cloudinit_master_node" {
#  template = file("./templates/userdata.yaml") 
template = file("${path.module}/templates/userdata_m.yaml")
  vars = {

    vsphere_server      = var.vsphere_server
    vsphere_host_ip     = var.vsphere_host_ip
    vsphere_user        = var.vsphere_user
    vsphere_password    = var.vsphere_password
    dcname              = var.dcname
    dcstore_name        = var.dcstore_name
    esxi_host_name      = var.esxi_host_name
    vsphere_clustername = var.vsphere_clustername

    vm_user_name        = var.vm_user_name
    vm_user_password    = var.vm_user_password
    vm_user_displayname = var.vm_user_displayname     
    vm_user_ssh_key     = var.vm_user_ssh_key
    vm_user_ssh_pk      = var.vm_user_ssh_pk

    ansible_repo_url    = var.ansible_repo_url
    ansible_repo_name   = var.ansible_repo_name
    ansible_playbook    = var.ansible_playbook
    
    os_admin_username   = var.os_admin_username
    os_nic1_name        = var.os_nic1_name

    k8s_ver             = var.k8s_ver
    k8s_version_short   = var.k8s_version_short
    calico_version      = var.calico_version
    vsphere_csi_driver_version = var.vsphere_csi_driver_version
    k8s_controlPlane_Endpoint = var.k8s_controlPlane_Endpoint
    k8s_service_subnet  = var.k8s_service_subnet
    k8s_pod_subnet      = var.k8s_pod_subnet
    calico_network_cidr_blocksize = var.calico_network_cidr_blocksize
    k8s_cluster_id      = var.k8s_cluster_id
    sc_storage_policy_name = var.sc_storage_policy_name
    sc_name             = var.sc_name
    hosts_entry1        = "${var.vms.masters.ip_pool[0]}  ${var.vms.masters.pref-0}"
    hosts_entry2        = "${var.vms.masters.ip_pool[1]}  ${var.vms.masters.pref-1}"
    hosts_entry3        = "${var.vms.workers.ip_pool[0]}  ${var.vms.workers.pref-0}"
    hosts_entry4        = "${var.vms.workers.ip_pool[1]}  ${var.vms.workers.pref-1}"
    hosts_entry5        = "${var.vms.workers.ip_pool[2]}  ${var.vms.workers.pref-2}"
    master0_ip          =  "${var.vms.masters.ip_pool[0]}"
    master1_ip          =  "${var.vms.masters.ip_pool[1]}"
    worker0_ip          =  "${var.vms.workers.ip_pool[0]}" 
    worker1_ip          =  "${var.vms.workers.ip_pool[1]}"
    worker2_ip          =  "${var.vms.workers.ip_pool[2]}"
    
  }
}
data "template_file" "cloudinit_worker_node" {
#  template = file("./templates/userdata.yaml") 
template = file("${path.module}/templates/userdata_w.yaml")
  vars = {

    vsphere_server      = var.vsphere_server
    vsphere_host_ip     = var.vsphere_host_ip
    vsphere_user        = var.vsphere_user
    vsphere_password    = var.vsphere_password
    dcname              = var.dcname
    dcstore_name        = var.dcstore_name
    esxi_host_name      = var.esxi_host_name
    vsphere_clustername = var.vsphere_clustername

    vm_user_name        = var.vm_user_name
    vm_user_password    = var.vm_user_password
    vm_user_displayname = var.vm_user_displayname     
    vm_user_ssh_key     = var.vm_user_ssh_key

    ansible_repo_url    = var.ansible_repo_url
    ansible_repo_name   = var.ansible_repo_name
    ansible_playbook    = var.ansible_playbook
    k8s_ver             = var.k8s_ver
    k8s_version_short   = var.k8s_version_short
    calico_version      = var.calico_version
    vsphere_csi_driver_version = var.vsphere_csi_driver_version
    k8s_controlPlane_Endpoint = var.k8s_controlPlane_Endpoint
    k8s_service_subnet  = var.k8s_service_subnet
    k8s_pod_subnet      = var.k8s_pod_subnet
    calico_network_cidr_blocksize = var.calico_network_cidr_blocksize
    k8s_cluster_id      = var.k8s_cluster_id
    sc_storage_policy_name = var.sc_storage_policy_name
    sc_name             = var.sc_name
  }
}
  ##experiment here
data "template_file" "metadata" {
#  template = file("./templates/userdata.yaml") 
template = file("${path.module}/templates/metadata.yaml")
  vars = {
    ipv4_gateway = var.vm_ipv4_gw
    dns_server   = var.vm_dns_server
  }

  #end of expiriment

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

 
resource "vsphere_virtual_machine" "k8s_masters_vm"  {
  name             = "${var.vms.masters.pref}-${count.index}"
  #"${var.vms.masters.pref}-${var.vms.masters.ip_pool[count.index]}
  count            = var.vms.masters.vm_count
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  host_system_id   = data.vsphere_host.host.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.vms.masters.vm_cpu_count
  memory           = var.vms.masters.vm_ram_size
  guest_id         = "ubuntu64Guest"
  folder           = var.vsphere_vm_folder
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.vms.masters.vm_disk_size
  }

  cdrom {
    client_device = true
  }
  
  clone {
     template_uuid = data.vsphere_virtual_machine.template_from_ovf.id

  }
 
  vapp {
  properties = {  }
  }

  extra_config = {
     "guestinfo.userdata" = base64encode(data.template_file.cloudinit_master_node.rendered)
     "guestinfo.userdata.encoding" = "base64"
     "guestinfo.metadata" = base64encode(replace((replace((data.template_file.metadata.rendered), "vm_ip_address",var.vms.masters.ip_pool[count.index])), "os_host_name", "${var.vms.masters.pref}-${count.index}"))
     "guestinfo.metadata.encoding" = "base64"
    
  }  

}

resource "vsphere_virtual_machine" "k8s_workers_vm"  {
  name             = "${var.vms.workers.pref}-${count.index}"
  #"${var.vms.masters.pref}-${var.vms.masters.ip_pool[count.index]}
  count            = var.vms.workers.vm_count
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  host_system_id   = data.vsphere_host.host.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.vms.workers.vm_cpu_count
  memory           = var.vms.workers.vm_ram_size
  guest_id         = "ubuntu64Guest"
  folder           = var.vsphere_vm_folder
  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.vms.workers.vm_disk_size
  }

  cdrom {
    client_device = true
  }
  
  clone {
     template_uuid = data.vsphere_virtual_machine.template_from_ovf.id

  }
 
  vapp {
  properties = {  }
  }

  extra_config = {
     "guestinfo.userdata" = base64encode(data.template_file.cloudinit_worker_node.rendered)
     "guestinfo.userdata.encoding" = "base64"
     "guestinfo.metadata" = base64encode(replace((replace((data.template_file.metadata.rendered), "vm_ip_address",var.vms.workers.ip_pool[count.index])), "os_host_name", "${var.vms.workers.pref}-${count.index}"))
     "guestinfo.metadata.encoding" = "base64"
    
  }  

}



#resource "vsphere_virtual_machine" "k8s_workers_vm"  {
#  name             = "${var.vm_name_pref}-${count.index}"
#  count            = 3
#  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
#  host_system_id   = data.vsphere_host.host.id
#  datastore_id     = data.vsphere_datastore.datastore.id
#  num_cpus         = var.vm_cpu_count
#  memory           = var.vm_ram_size
#  guest_id         = "ubuntu64Guest"
#  folder           = var.vsphere_vm_folder
#  network_interface {
#    network_id = data.vsphere_network.network.id
#  }
#
#  disk {
#    label = "disk0"
#    size  = var.vm_disk_size
#  }
#
#  cdrom {
#    client_device = true
#  }
#  
#  clone {
#     template_uuid = data.vsphere_virtual_machine.template_from_ovf.id
#
#  }
# 
#  vapp {
#  properties = {  }
#  }
#
#  extra_config = {
#     "guestinfo.userdata" = base64encode(data.template_file.cloud-init.rendered)
#     "guestinfo.userdata.encoding" = "base64"
#     "guestinfo.metadata" = base64encode(replace((replace((data.template_file.metadata.rendered), "vm_ip_address",var.vm_ipv4_address[count.index])), "os_host_name", "${var.vm_name_pref}-${count.index}"))
#     "guestinfo.metadata.encoding" = "base64"
#    
#  }  
#
#}
#
##out