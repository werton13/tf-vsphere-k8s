# --- vSphere variables ---
variable "vsphere_server" {
  type        = string
  default     = ""
  description = "vsphere_server"
 }
variable "vsphere_host_ip"  {
  type        = string
  default     = ""
  description = "description"
 }
variable "vsphere_vm_folder" {
  type        = string
  default     = ""
  description = "description"
 }

variable "vsphere_user" {
  description = ""
  default = ""
 }
variable "vsphere_password" {
  type        = string
  default     = ""
  description = "password for vsphere account"
 }

variable "dcname" {
  type        = string
  default     = "99Cloud-HUB"
  description = "description"
 }
variable "dcstore_name" {
  type        = string
  default     = ""
  description = "description"
 }

variable "esxi_host_name" {
  type        = string
  default     = ""
  description = "description"
 }
variable "vsphere_clustername" {
  type        = string
  default     = ""
  description = "vsphere clustername"
 }
variable "vm_template_name"  {
   type        = string
   default     = ""
   description = "virtual machine template name prepared for cloud-init customisation"
 }

variable "vm_hardware_version" {
   default = 19 #15
   type = number
 }

variable "vnet_name" {
   type        = string
   default     = ""
   description = "virtual network name"
 }


variable "vm_user_name" {
   type        = string
   default     = ""
   description = "user name for a new vm user"
 }
variable "vm_user_password" {
  type        = string
  default     = ""
  description = "description"
 }

variable "vm_user_displayname" {
   type        = string
   default     = ""
   description = "user  display name for a new vm user"
 }

variable "vm_user_ssh_key" {
   type        = string
   default     = ""
   description = "user ssh key for a new vm user"
 }

variable "vm_ipv4_gw" {
  type        = string
  default     = ""
  description = "description"
 }
variable "vm_dns_server" {
  type        = string
  default     = ""
  description = "description"
 }

variable "vms" {
    type = map(object({
        pref = string
        vm_cpu_count = string
        vm_ram_size  = string
        vm_disk_size = string
        vm_count = string
        ip_pool = list(string)
    }))
 }

#Additional disks vars
variable "add_disks" {
  type = map(object({
    sizegb          = string
    bus_num         = string
    unit_num        = string
    storage_profile = string
    bus_type        = string
  }))
  default = {
          diskm1 = {
            sizegb = "10"
            bus_num = "1"
            unit_num = "0"
            storage_profile = ""
            bus_type = "paravirtual" 
          }
          diskm2 = {
            sizegb = "30"
            bus_num = "1"
            unit_num = "1"
            storage_profile = ""
            bus_type = "paravirtual"  
          }
          diskw1 = {
            sizegb = "10"
            bus_num = "1"
            unit_num = "0"
            storage_profile = ""
            bus_type = "paravirtual" 
          }
          diskw2 = {
            sizegb = "30"
            bus_num = "1"
            unit_num = "1"
            storage_profile = ""
            bus_type = "paravirtual"  
          }
 }
}

############ for Ansible playbook
variable "ansible_repo_url" {
   type        = string
   default     = "https://github.com/werton13/k8s-kubeadm-r2.git"
   description = "ansible playbook URL for vm advanced customizations"
 }
variable ansible_repo_branch {
  type        = string
  default     = "dev"
  description = "description"
}
variable "ansible_repo_name"  {
  type        = string
  default     = "k8s-kubeadm-r2"
  description = "ansible git repository name for kubernetes cluster bootstrap"
 }
variable "ansible_playbook" {
   type        = string
   default     = "main.yaml"
   description = "ansible playbook for ansible git repository name for kubernetes cluster bootstrap"
 }
variable "os_admin_username" {
  type        = string
  default     = "kuberadm"
  description = "description"
 }
variable "os_nic1_name" {
  type        = string
  default     = ""
  description = "description"
 }
variable ansible_ssh_pass {
  type        = string
  default     = ""
  description = "description"
 }



############# Versions of components

variable "k8s_ver" {
  type        = string
  default     = "1.28.6-1.1"
  description = "description"
 }
variable "k8s_version_short" {
  type        = string
  default     = "1.28.6"
  description = "description"
 }
variable "calico_version" {
  type        = string
  default     = "v3.27.2"
  description = "description"
 }
variable "vsphere_csi_driver_version" {
  type        = string
  default     = ""
  description = "description"
 }

variable helm_version {
  type        = string
  default     = "v3.11.1"
  description = "Helm version "
}

variable k8s_cluster_name {
  type        = string
  default     = "k8s_cluster"
  description = "k8s cluster name "
}

variable "k8s_controlPlane_Endpoint" {
  type        = string
  default     = ""
  description = "description"
 }
variable "k8s_service_subnet" {
  type        = string
  default     = ""
  description = "description"
 }
variable "k8s_pod_subnet" {
  type        = string
  default     = ""
  description = "description"
 }
variable "calico_network_cidr_blocksize" {
  type        = string
  default     = ""
  description = "description"
 }
variable "k8s_cluster_id" {
  type        = string
  default     = ""
  description = "The unique cluster identifier. DISPLAYED IN VSPHERE CONSOLE(CONTAINER VOLUMES DETAILS)"
 }
variable "sc_storage_policy_name" {
  type        = string
  default     = ""
  description = "description"
 }
variable "sc_name" {
  type        = string
  default     = ""
  description = "description"
 }
variable vm_user_ssh_pk {
  type        = string
  default     = ""
  description = "description"
}

variable ingress_ext_fqdn {
  type        = string
  default     = ""
  description = "FQDN to build general prefix for the K8s Ingress controller endpoint's, published to outside"
}

# sensitive variables for Alert manager telegram integration
variable alertmgr_telegram_receiver_name {
  type        = string
  default     = ""
  description = "alert manager receiver name for a Telegram receiver"
}
variable alertmgr_telegram_bot_token {
  type        = string
  default     = ""
  description = "telegram bot token for alertmanager integration"
}
variable alertmgr_telegram_chatid {
  type        = string
  default     = ""
  description = "telegram chat_id for alertmanager integration"
}

variable docker_mirror {
  type        = string
  default     = "mirror.gcr.io"
  description = "allow to change global image registry from docker.io to some mirror, default google mirror"
}


variable ingress_controller_nodeport_http {
  type        = string
  default     = "30888"
  description = "node port value for ingress controller service http endpoint"
}
variable ingress_controller_nodeport_https {
  type        = string
  default     = "30443"
  description = "node port value for ingress controller service https endpoint"
}

variable "def_dns" {
  type        = string
  default     = ""
  description = "default dns ip address configured in the template"
}
variable "env_dns1" {
  type        = string
  default     = ""
  description = "description"
}
variable "env_dns2" {
  type        = string
  default     = ""
  description = "description"
}

variable tenant_cluster_ro_rolename {
  type        = string
  default     = ""
  description = "description"
}

variable tenant_ns_default {
  type        = string
  default     = ""
  description = "description"
}
variable tenant_k8s_admin_username {
  type        = string
  default     = ""
  description = "description"
}
variable tenant_orgname {
  type        = string
  default     = ""
  description = "description"
}
variable tenant_orgname_orgunit {
  type        = string
  default     = ""
  description = "description"
}
variable tenant_emailaddress {
  type        = string
  default     = ""
  description = "description"
}
variable certificate_validity {
  type        = string
  default     = "30"
  description = "description"
}












