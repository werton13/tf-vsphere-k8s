
variable vsphere_clustername {
  type        = string
  default     = ""
  description = "vsphere clustername"
}

variable dcname {
  type        = string
  default     = "99Cloud-HUB"
  description = "description"
}
variable dcstore_name {
  type        = string
  default     = ""
  description = "description"
}

variable vsphere_host_ip  {
  type        = string
  default     = ""
  description = "description"
}

variable esxi_host_name {
  type        = string
  default     = ""
  description = "description"
}

 variable vm_name {
   type        = string
   default     = ""
   description = "vm name"
 }
 variable vm_cpu_count {
   type        = string
   default     = "2"
   description = "quantity of cpu cores for virtual machine"
 }
 variable vm_ram_size {
   type        = string
   default     = "1024"
   description = "Amount of RAM allocated for virtual machine"
 }
 variable vm_disk_size {
   type        = string
   default     = "20"
   description = "system disk size allocated for virtual machine"
 }
 variable vm_template_name  {
   type        = string
   default     = ""
   description = "virtual machine template name prepared for cloud-init customisation"
 }
 variable vnet_name {
   type        = string
   default     = ""
   description = "virtual network name"
 }
 
 variable vm_user_name {
   type        = string
   default     = ""
   description = "user name for a new vm user"
 }
  variable vm_user_displayname {
   type        = string
   default     = ""
   description = "user  display name for a new vm user"
 }
 
  variable vm_user_password {
   type        = string
   default     = ""
   description = "user password for a new vm user - should be SHA512 hash from desired password"
 }
  variable vm_user_ssh_key {
   type        = string
   default     = ""
   description = "user ssh key for a new vm user"
 }
  variable ansible_repo_url {
   type        = string
   default     = "https://github.com/werton13/Ansible-DSKLinuxCustom.git"
   description = "ansible playbook URL for vm advanced customisations"
 }
 
 variable  ansible_playbook{
   type        = string
   default     = "main.yaml"
   description = "ansible playbook for vm advanced customisations"
 }
variable vm_ssh_port {
  type        = string
  default     = "22"
  description = "vm ssh port to open - can be custom, default 22"
}
variable ansible_repo_name  {
  type        = string
  default     = "Ansible-DSKLinuxCustom"
  description = "ansible git repository name for vm advanced customisations"
}
variable vnc_password {
  type        = string
  default     = ""
  description = "password for connecting to a VNC server - it is different from vm user password"
}


 

