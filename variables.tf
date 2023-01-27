# vSphere variables 
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

############ for Ansible playbook
variable "ansible_repo_url" {
   type        = string
   default     = "https://github.com/werton13/Ansible-DSKLinuxCustom.git"
   description = "ansible playbook URL for vm advanced customisations"
 }
variable "ansible_repo_name"  {
  type        = string
  default     = "Ansible-DSKLinuxCustom"
  description = "ansible git repository name for vm advanced customisations"
 }
variable "ansible_playbook" {
   type        = string
   default     = "main.yaml"
   description = "ansible playbook for vm advanced customisations"
 }
variable "os_admin_username" {
  type        = string
  default     = ""
  description = "description"
 }
variable "os_nic1_name" {
  type        = string
  default     = ""
  description = "description"
 }



############# Versions of components

variable "k8s_ver" {
  type        = string
  default     = ""
  description = "description"
 }
variable "k8s_version_short" {
  type        = string
  default     = ""
  description = "description"
 }
variable "calico_version" {
  type        = string
  default     = ""
  description = "description"
 }
variable "vsphere_csi_driver_version" {
  type        = string
  default     = ""
  description = "description"
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





















