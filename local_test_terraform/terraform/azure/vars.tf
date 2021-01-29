variable "azure_region" {
  type = string
  default = "centralus"
}

variable "admin_username" {
  type = string
  default = "paloalto"
}

variable "admin_password" {
  type = string
  default = "Super Secret 1!"
}

variable "resource_group_name" {
  type = string
  default = "topology_1_ngfw_2_hosts"
}

variable "ngfw_version" {
  type = string
  default = "10.0.3"
}

#### Topology vnet ####

variable "topology_cidr" {
  type = string
  default = "192.168.0.0/16"
}

#### Management Subnet ####

variable "mgmt_subnet_cidr" {
  type = string
  default = "192.168.128.0/24"
}

variable "fw_mgmt_ip" {
  type = string
  default = "192.168.128.65"
}

variable "client_01_mgmt_ip" {
  type = string
  default = "192.168.128.66"
}

variable "client_02_mgmt_ip" {
  type = string
  default = "192.168.128.67"
}

#### Trust Subnet ####

variable "trust_subnet_cidr" {
  type = string
  default = "192.168.0.0/24"
}

variable "fw_trust_ip" {
  type = string
  default = "192.168.0.65"
}

variable "client_01_trust_ip" {
  type = string
  default = "192.168.0.66"
}

#### Untrust Subnet ####

variable "untrust_subnet_cidr" {
  type = string
  default = "192.168.254.0/24"
}

variable "fw_untrust_ip" {
  type = string
  default = "192.168.254.65"
}

#### DMZ Subnet ####

variable "dmz_subnet_cidr" {
  type = string
  default = "192.168.253.0/24"
}

variable "fw_dmz_ip" {
  type = string
  default = "192.168.253.65"
}

variable "client_02_dmz_ip" {
  type = string
  default = "192.168.253.67"
}

