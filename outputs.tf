output "vm_public_ip" {
description = "IP pública de la máquina virtual"
value = azurerm_public_ip.public_ip.ip_address
}