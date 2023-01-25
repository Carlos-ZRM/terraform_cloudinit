variable "project" {
  type = string
  default = "carlos-xpk"
}

# az account list-locations --query "[].{DisplayName:displayName, Name:name,region:regionalDisplayName}" -o table 
variable "azure_region" {
  type = string
  default = "East US"
}

variable "azure_vn_cidr" {
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "azure_vn_subnet" {
  type = list(list(string))
  default = [
    ["10.0.1.0/24"],
    ["10.0.2.0/24"]
  ]
}

variable "count_vm" {
  type = number
  default = 1
}