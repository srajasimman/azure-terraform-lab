## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/linux_virtual_machine) | resource |
| [azurerm_mysql_flexible_database.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/mysql_flexible_database) | resource |
| [azurerm_mysql_flexible_server.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/mysql_flexible_server) | resource |
| [azurerm_mysql_flexible_server_firewall_rule.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/mysql_flexible_server_firewall_rule) | resource |
| [azurerm_network_interface.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.public](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.web-app](https://registry.terraform.io/providers/hashicorp/azurerm/4.8.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The admin password of the web application | `string` | `"P@ssw0rd1234!"` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The admin username of the web application | `string` | `"adminuser"` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment of the web application | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which all resources in this example should be created. | `string` | `"East US"` | no |
| <a name="input_mysql_sku_name"></a> [mysql\_sku\_name](#input\_mysql\_sku\_name) | The sku of the web application | `string` | `"B_Gen5_2"` | no |
| <a name="input_mysql_storage_gb"></a> [mysql\_storage\_gb](#input\_mysql\_storage\_gb) | The storage of the web application | `string` | `"5120"` | no |
| <a name="input_mysql_version"></a> [mysql\_version](#input\_mysql\_version) | The version of the web application | `string` | `"5.7"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the web application | `string` | `"web-app"` | no |
| <a name="input_net_cidr"></a> [net\_cidr](#input\_net\_cidr) | The network cidr of the web application | `string` | `"10.0.0.0/16"` | no |
| <a name="input_port"></a> [port](#input\_port) | The port of the web application | `map(any)` | <pre>{<br/>  "443": "1002",<br/>  "80": "1001"<br/>}</pre> | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | The subnet cidr of the web application | `string` | `"10.0.1.0/24"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Subscription ID which should be used | `string` | n/a | yes |
| <a name="input_vm_os_offer"></a> [vm\_os\_offer](#input\_vm\_os\_offer) | The offer of the web application | `string` | `"UbuntuServer"` | no |
| <a name="input_vm_os_publisher"></a> [vm\_os\_publisher](#input\_vm\_os\_publisher) | The publisher of the web application | `string` | `"Canonical"` | no |
| <a name="input_vm_os_sku"></a> [vm\_os\_sku](#input\_vm\_os\_sku) | The sku of the web application | `string` | `"18.04-LTS"` | no |
| <a name="input_vm_os_version"></a> [vm\_os\_version](#input\_vm\_os\_version) | The version of the web application | `string` | `"latest"` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the web application | `string` | `"Standard_B1s"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_web_app_public_ip"></a> [web\_app\_public\_ip](#output\_web\_app\_public\_ip) | Output the public IP address of the web application |
