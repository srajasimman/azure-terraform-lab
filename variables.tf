variable "subscription_id" {
  type        = string
  description = "The Subscription ID which should be used"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "The Azure Region in which all resources in this example should be created."
}

variable "name" {
  type        = string
  default     = "web-app"
  description = "The name of the web application"
}

variable "env" {
  type        = string
  default     = "dev"
  description = "The environment of the web application"
}

variable "net_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The network cidr of the web application"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The subnet cidr of the web application"
}

variable "port" {
  type = map(any)
  default = {
    "80"  = "1001"
    "443" = "1002"
  }
  description = "The port of the web application"
}

variable "vm_size" {
  type        = string
  default     = "Standard_B1s"
  description = "The size of the web application"
}

variable "vm_os_publisher" {
  type        = string
  default     = "Canonical"
  description = "The publisher of the web application"
}

variable "vm_os_offer" {
  type        = string
  default     = "UbuntuServer"
  description = "The offer of the web application"
}

variable "vm_os_sku" {
  type        = string
  default     = "18.04-LTS"
  description = "The sku of the web application"
}

variable "vm_os_version" {
  type        = string
  default     = "latest"
  description = "The version of the web application"
}

variable "vm_ssh_pub_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "The Public Key which should be used for authentication"
}

variable "admin_username" {
  type        = string
  default     = "adminuser"
  description = "The admin username of the web application"
}

variable "admin_password" {
  type        = string
  default     = "P@ssw0rd1234!"
  description = "The admin password of the web application"
}

variable "mysql_sku_name" {
  type        = string
  default     = "B_Gen5_2"
  description = "The sku of the web application"
}

variable "mysql_storage_gb" {
  type        = string
  default     = "5120"
  description = "The storage of the web application"
}

variable "mysql_version" {
  type        = string
  default     = "5.7"
  description = "The version of the web application"
}

