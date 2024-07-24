## Kubernetes cluster deployment on a VMware vSphere platform

This module intended to deploy Kubernetes cluster inside a tenant on standard VMware vSphere platform.
It is creating set of virtual machines for K8s control and data plane, make their preparation, bootstrap Kubernetes cluster, add all defined members and install a set of Kubernetes addons.

All customusation and configuration performing by a dedicated Ansible playbook: https://github.com/werton13/k8s-kubeadm-ansible.git which is created specifically for this project and hardcoded into module as default value.

Ansible playbook run from a first master node.

Currently the following list of Kubernetes addons installing:


  - Tigera operator for Calico CNI: https://docs.tigera.io/calico/3.25/about
  - vCloud CSI driver: https://docs.vmware.com/en/VMware-vSphere-Container-Storage-Plug-in/index.html
  - Kubernetes metrics server: https://github.com/kubernetes-sigs/metrics-server
  - Prometheus Monitoring Community: https://github.com/prometheus-community
    * Prometheus alerting rules defined (under construction)
    * Alert Manager config with Telegram integration
  - Grafana Labs Grafana: https://github.com/grafana
    * Preconfigured for Prometheus source
    * Preinstalled the following dashboards:
      + Node Exporter Full: https://grafana.com/grafana/dashboards/1860-node-exporter-full/
      + kube-state-metrics-v2: https://grafana.com/grafana/dashboards/13332-kube-state-metrics-v2/
      + Prometheus Stats: https://grafana.com/grafana/dashboards/358-prometheus-stats/
  - Ingress NGINX Controller:  https://kubernetes.github.io/ingress-nginx/


#### HOW TO USE:

<b>To use this module you have to fill provider block and specify required variables as in the example below:</b>


```hcl
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  version = "2.4.0"
}


module "vsphere-k8s-cluster" {
  source = "github.com/werton13/tf-vsphere-k8s"

  vsphere_server             = var.vsphere_server
  vsphere_host_ip            = var.vsphere_host_ip
  vsphere_vm_folder          = var.vsphere_vm_folder
  vsphere_user               = var.vsphere_user
  vsphere_password           = var.vsphere_password
  dcname                     = var.dcname
  dcstore_name               = var.dcstore_name
  esxi_host_name             = var.esxi_host_name
  vsphere_clustername        = var.vsphere_clustername
  vm_template_name           = var.vm_template_name
  vnet_name                  = var.vnet_name

  vm_user_name               = var.vm_user_name
  vm_user_password           = var.vm_user_password
  vm_user_displayname        = var.vm_user_displayname
  vm_user_ssh_key            = var.vm_user_ssh_key

  vm_ipv4_gw                 = var.vm_ipv4_gw
  vm_dns_server              = var.vm_dns_server

  ansible_ssh_pass           = var.ansible_ssh_pass
  ansible_repo_url           = var.ansible_repo_url
  ansible_repo_branch        = var.ansible_repo_branch
  ansible_repo_name          = var.ansible_repo_name

  k8s_cluster_name           = var.k8s_cluster_name
  k8s_controlPlane_Endpoint  = var.k8s_controlPlane_Endpoint
  k8s_cluster_id             = var.k8s_cluster_id
  sc_storage_policy_name     = var.sc_storage_policy_name
  sc_name                    = var.sc_name

  ingress_ext_fqdn           = var.ingress_ext_fqdn
  ingress_controller_nodeport_http  = var.ingress_controller_nodeport_http
  ingress_controller_nodeport_https = var.ingress_controller_nodeport_https

  os_nic1_name               = var.os_nic1_name
  os_admin_username          = var.os_admin_username
  
  def_dns  = var.def_dns
  env_dns1 = var.env_dns1
  env_dns2 = var.env_dns2

  alertmgr_telegram_receiver_name = var.alertmgr_telegram_receiver_name
  alertmgr_telegram_bot_token     = var.alertmgr_telegram_bot_token
  alertmgr_telegram_chatid        = var.alertmgr_telegram_chatid

  vms = var.vms
  add_disks = var.add_disks

  tenant_cluster_ro_rolename = var.tenant_cluster_ro_rolename
  tenant_ns_default          = var.tenant_ns_default
  tenant_k8s_admin_username  = var.tenant_k8s_admin_username
  tenant_orgname             = var.tenant_orgname
  tenant_orgname_orgunit     = var.tenant_orgname_orgunit
  tenant_emailaddress        = var.tenant_emailaddress
  certificate_validity       = var.certificate_validity
  
  k8s_ver           = var.k8s_ver  
  k8s_version_short = var.k8s_version_short
  calico_version    = var.calico_version
  docker_mirror     = var.docker_mirror 
  vsphere_csi_driver_version = var.vsphere_csi_driver_version

  k8s_service_subnet = var.k8s_service_subnet
  k8s_pod_subnet     = var.k8s_pod_subnet

  vm_user_ssh_pk = <<-EOT
  '-----BEGIN OPENSSH PRIVATE KEY-----
   ---
   -----END OPENSSH PRIVATE KEY-----'
   EOT
}

```
<details>
  <summary><b>Default values</b></summary>

```  
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
docker_mirror     = "mirror.gcr.io"
ansible_repo_url  = "https://github.com/werton13/k8s-kubeadm-r2.git"
ansible_repo_name = "k8s-kubeadm-r2"
ansible_repo_branch = "dev"
ansible_playbook = "main.yaml"

os_admin_username = "kuberadm"

k8s_ver           = "1.28.6-1.1"
k8s_version_short = "1.28.6"
calico_version    = "v3.27.2"

k8s_service_subnet = "10.96.0.0/12"
k8s_pod_subnet     = "10.244.0.0/22"
calico_network_cidr_blocksize = "26"

```

</details>