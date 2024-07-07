# vSphere variables 
vsphere_server = "99chlab-vcp01.mtscloud.local"
vsphere_host_ip = "10.99.120.66"
vsphere_vm_folder = "" #"/DC name as in dcname variable/vm/Your-K8s-Lab"

vsphere_user = "vsphre_username"
vsphere_password = "vsphere_usersecretpassword"

dcname = "vsphere dc name"
dcstore_name = "vsphere datastore name"

esxi_host_name = "esxi host name"
vsphere_clustername = "vsphere cluster name"
vm_template_name = "ubuntu-22.04-template"

vnet_name = "vsphere virtual network to attach vms"

vm_user_name  = "vm os admin name" # will be created
vm_user_displayname = "cluster admin"
vm_user_password = "$6$rounds=---"
vm_user_ssh_key = "ssh-ed25519 somessh pub key here lab@kubernetes"

vm_ipv4_gw    = "ip gateway to use in vm ip configuration"
vm_dns_server = "dns server to be configured in vms ip configuration "


vms = {
    dvm = {
      pref = "dvm"
      vm_cpu_count = "2"
      vm_ram_size  = "4096"
      vm_disk_size = "20"
      vm_count = "1"
      ip_pool = ["192.168.253.100/24"]
    }  
    masters = {
      pref = "k8s-mst"
      vm_cpu_count = "2"
      vm_ram_size  = "4096"
      vm_disk_size = "40"
      vm_count = "3"
      ip_pool =  ["192.168.253.11/24", 
                  "192.168.253.12/24",
                  "192.168.253.13/24"]
    },
    workers = {
      pref = "k8s-wrk"
      vm_cpu_count = "4"
      vm_ram_size  = "8192"
      vm_disk_size = "40"
      vm_count = "3"
      ip_pool =  ["192.168.253.14/24",
                  "192.168.253.15/24",
                  "192.168.253.16/24"]

    }
}

add_disks = {
          disk1 = {
            sizegb = "10"
            bus_num = "1"
            unit_num = "0"
            storage_profile = ""
            bus_type = "paravirtual" 
          }
          disk2 = {
            sizegb = "30"
            bus_num = "1"
            unit_num = "1"
            storage_profile = ""
            bus_type = "paravirtual"  
          }
}


docker_mirror      = "mirror.gcr.io"

ansible_repo_url = "https://github.com/werton13/k8s-kubeadm-r2.git"
ansible_repo_name =  "k8s-kubeadm-r2"
ansible_repo_branch = "dev"
ansible_playbook = "main.yaml"

os_admin_username = "os admin username" #should be the same as vm_user_name
os_nic1_name = "ens192"
ansible_ssh_pass = "P@ssw0rd$"

############# Versions of components

#k8s_ver = "1.24.9-00"
#k8s_ver = "1.22.17-00"
k8s_ver = "1.28.6-1.1"

#k8s_version_short = "v1.24.0"
#k8s_version_short = "1.22.0"
k8s_version_short = "1.28.6"

#calico_version = "v3.24.5"
#calico_version = "v3.25.0"
calico_version = "v3.27.2"
vsphere_csi_driver_version = "v3.0.2"

def_dns  = "8.8.8.8"    # dns server configured inside vm ip configuration
env_dns1 = "77.88.8.8"  # dns servers,specific to environment - to replace default dns in ip configuration   
env_dns2 = "77.88.8.1"  # dns servers,specific to environment - to replace default dns in ip configuration

############# K8s Networking parameters
k8s_controlPlane_Endpoint = "kubernetes cluster contolplane IP -usually ip of Load Balancer" #My haproxy LB
k8s_service_subnet = "10.96.0.0/12"
k8s_pod_subnet = "10.244.0.0/22"
calico_network_cidr_blocksize = "26"

# vSphere CPI & CSI vars

k8s_cluster_id = "your-K8s-cluster id" #The unique cluster identifier. DISPLAYED IN VSPHERE CONSOLE(CONTAINER VOLUMES DETAILS)
sc_storage_policy_name = "StoragePolicy01"

sc_name = "ssd-default" # your storage class name
vm_user_ssh_pk = <<-EOT
'-----BEGIN OPENSSH PRIVATE KEY-----
 ---
-----END OPENSSH PRIVATE KEY-----'
EOT

ingress_ext_fqdn = "testground.lab"

alertmgr_telegram_receiver_name = "test-telegram"
alertmgr_telegram_bot_token = " telegram bot token "
alertmgr_telegram_chatid = "-telegram chat id"

############# K8s RBAC paramaters
tenant_cluster_ro_rolename = "tenant-cluster-readonly"
tenant_ns_default = "mts-tenantns-default"
tenant_k8s_admin_username = "tenant-admin"
tenant_orgname = "tenant-orgname"
tenant_orgname_orgunit = "tenant-orgname-k8s"
tenant_emailaddress = "tenant-admin@tenant-orgname.lab"
certificate_validity = "180"  #30/60 or 180 и.т.д.

######################################################################

helm_version = "v3.11.1"
k8s_cluster_name = "k8s-lab"
ingress_controller_nodeport_http = "30888"
ingress_controller_nodeport_https = "30443"
