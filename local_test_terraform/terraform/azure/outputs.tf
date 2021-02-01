output "ngfw_ip_address" {
  value = azurerm_public_ip.fw_mgmt_ip
}

output "client_01_ip_address" {
  value = azurerm_public_ip.client_01_mgmt_ip
}

output "client_02_ip_addrress" {
  value = azurerm_public_ip.client_02_mgmt_ip
}

