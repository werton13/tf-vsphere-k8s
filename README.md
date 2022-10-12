This terraform module intended for  building and configuring a virtual machine
using vsphere terrform provider from Linux Desktop OS template
This Desktop Virtual Machine purpose is for build and deploy different Terraform and K8s payloads and it should provide GUI environment with all required tools
Template should already have KDE preinstalled
v1.
Below configuration applied via cloud-init:


# 1) add user with username and password specified in variables +
# 2) install openssh-server
# 3) copy generated ssh pub key to authorized_keys
# 4) install following software:
  # - ansible
  # - net-tools
  # - nmap
  # - git
  # - openssh-server
  # - tigervnc-common
  # - tigervnc-standalone-server
  # - tigervnc-xorg-extension
  # - dbus-x11
# 5) download and run Ansible playbook
I'm use my own playbook: https://github.com/werton13/Ansible-DSKLinuxCustom.git

Below configuration applied via Ansible:

# 1) change default SSH port to specified in variables
# 2) disable SSH password authentication
# 3)  modify /etc/hosts to add Lab vsphere ESXi host specified in variables
# 4) create xstartup file for vncserver
# 5) create service for vnc user with username specified in variables
# 6) copy terraform binary to local system folder
# 7) copy terraform vsphere and template providers to local user folders

# not implemented yet 
#  install additional software requiring complex installtion ( kubectl, vs code, docker)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
HOW TO USE:
#######################################

will add a little later
 

######################################