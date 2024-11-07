# Output the public IP address of the web application
output "web_app_public_ip" {
  value = azurerm_public_ip.web-app.ip_address
}
