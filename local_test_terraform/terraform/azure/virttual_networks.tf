### Virtual Network ####

resource "azurerm_virtual_network" "topology" {
  name = "topology_virtual_network"
  address_space = [
    var.topology_cidr]
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

#### Subnets ####

resource "azurerm_subnet" "management" {
  name = "management"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.topology.name
  address_prefixes = [var.mgmt_subnet_cidr]
}

resource "azurerm_subnet" "untrust" {
  name = "untrust"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.topology.name
  address_prefixes = [var.untrust_subnet_cidr]
}

resource "azurerm_subnet" "trust" {
  name = "trust"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.topology.name
  address_prefixes = [var.trust_subnet_cidr]
}

resource "azurerm_subnet" "dmz" {
  name = "dmz"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.topology.name
  address_prefixes = [var.dmz_subnet_cidr]
}

#### Route tables ####

resource "azurerm_route_table" "management" {
  name = "management"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  route {
    name = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type = "internet"
  }
}

resource "azurerm_route_table" "untrust" {
  name = "untrust"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  route {
    name = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type = "internet"
  }
}

#### Route Table Associations ####

resource "azurerm_subnet_route_table_association" "management" {
  subnet_id = azurerm_subnet.management.id
  route_table_id = azurerm_route_table.management.id
}

resource "azurerm_subnet_route_table_association" "untrust" {
  subnet_id = azurerm_subnet.untrust.id
  route_table_id = azurerm_route_table.untrust.id
}

### Public IPs ####

resource "azurerm_public_ip" fw_mgmt_ip {
  name = "fw_mgmt_ip"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method = "Static"
}

resource "azurerm_public_ip" client_01_mgmt_ip {
  name = "client_01_mgmt_ip"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method = "Static"
}

resource "azurerm_public_ip" client_02_mgmt_ip {
  name = "client_02_mgmt_ip"
  location = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method = "Static"
}