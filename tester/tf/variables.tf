
variable "rg" {
  default = "new-transformer-dev2-identity-app-rg"
}

variable "postfix" {
  default = "tester"
}

variable "hosts" {
  default = "tester"
}

variable "instance_count" {
  default = "1"
}

variable "vm" {
  default = "vm-tester-001"
}

variable "pip" {
  default = "pip-tester-001"
}

variable "nsg" {
  default = "nsg-tester-001"
}

variable "nic" {
  default = "nic-tester-001"
}

variable "ptip" {
  default = "ptip-tester-002"
}

variable "hostname" {
  default = "tester-001"
}

variable "size" {
  description = "Standard_B2ms / Standard_B2s / Standard_DS1_v2 / Standard_DS1_v2 / Standard_F2 / Standard_A4_v2"
  default = "Standard_B2ms"
}

variable "osdisk" {
  default = "osdisk-tester-001"
}

variable "stype" {
  default = "Standard_LRS"
}

variable "disk_size" {
  default = "5"
}

variable "location" {
  default = "westus"
}

variable "vnet" {
  default = "vnet-new-transformer-dev2-001"
}

variable "subnet" {
  default = "subnet-tester-001"
}

variable "exdisk" {
  default = "exdisk-tester-001"
}

variable "tag" {
  default = "Demo Infrastructure"
}
