This terraform module intended for  building and configuring a virtual machine
using vsphere terrform provider from Linux Desktop OS template
This Desktop Virtual Machine purpose is for build and deploy different Terraform and K8s payloads and it should provide GUI environment with all required tools
Template should already have KDE preinstalled
v1.
Below configuration applied via cloud-init:


 1 add user with username and password specified in variables +
 2 install openssh-server
 3 copy generated ssh pub key to authorized_keys
 4 install following software:
   - ansible
   - net-tools
   - nmap
   - git
   - openssh-server
   - tigervnc-common
   - tigervnc-standalone-server
   - tigervnc-xorg-extension
   - dbus-x11
 5 download and run Ansible playbook
I'm use my own playbook: https://github.com/werton13/Ansible-DSKLinuxCustom.git

Below configuration applied via Ansible:

 1 change default SSH port to specified in variables
 2 disable SSH password authentication
 3  modify /etc/hosts to add Lab vsphere ESXi host specified in variables
 4 create xstartup file for vncserver
 5 create service for vnc user with username specified in variables
 6 copy terraform binary to local system folder
 7 copy terraform vsphere and template providers to local user folders

**not implemented yet** 
-  install additional software requiring complex installtion ( kubectl, vs code, docker).


HOW TO USE:
To use this module you have to fill provider block and specify required variables as in example below:

```hcl
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

module "new-mgmtvm" {
  source = "github.com/werton13/tf-vsphere-linux-vnc-vm"

   
   vsphere_clustername = var.vsphere_clustername
   dcname = var.dcname
   dcstore_name = var.dcstore_name
   vsphere_host_ip = var.vsphere_host_ip
   esxi_host_name = var.esxi_host_name
   vm_name = var.vm_name
   vm_cpu_count = var.vm_cpu_count
   vm_ram_size = var.vm_ram_size
   vm_disk_size = var.vm_disk_size
   vm_template_name = var.vm_template_name
   vnet_name = var.vnet_name
   vm_user_name = var.vm_user_name
   vm_user_displayname = var.vm_user_displayname
   vm_user_password = var.vm_user_password
   vm_user_ssh_key = var.vm_user_ssh_key
   ansible_repo_url = var.ansible_repo_url
   ansible_playbook = var.ansible_playbook
   vm_ssh_port = var.vm_ssh_port
   ansible_repo_name  = var.ansible_repo_name
   vnc_password = var.vnc_password

}
```
When specifying a password value you should provide it not in clear form but SHA-512 hash
you can prepare such password with a command:

```sh
mkpasswd --method=SHA-512 --rounds=4096
```
