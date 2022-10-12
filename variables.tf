
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
   description = "quantity of cpu"
 }
 variable vm_ram_size {
   type        = string
   default     = "1024"
   description = "vm RAM"
 }
 variable vm_disk_size {
   type        = string
   default     = "20"
   description = "vm disk size"
 }
 variable vm_template_name  {
   type        = string
   default     = ""
   description = "description"
 }
 variable vnet_name {
   type        = string
   default     = ""
   description = "virtual network name"
 }
 
 variable vm_user_name {
   type        = string
   default     = ""
   description = "description"
 }
  variable vm_user_displayname {
   type        = string
   default     = ""
   description = "description"
 }
 
  variable vm_user_password {
   type        = string
   default     = ""
   description = "description"
 }
  variable vm_user_ssh_key {
   type        = string
   default     = ""
   description = "description"
 }
  variable ansible_repo_url {
   type        = string
   default     = "https://github.com/werton13/Ansible-DSKLinuxCustom.git"
   description = "description"
 }
 
 variable  ansible_playbook{
   type        = string
   default     = "main.yaml"
   description = "description"
 }
variable vm_ssh_port {
  type        = string
  default     = ""
  description = "description"
}
variable ansible_repo_name  {
  type        = string
  default     = "Ansible-DSKLinuxCustom"
  description = "description"
}
variable vnc_password {
  type        = string
  default     = ""
  description = "description"
}


 

