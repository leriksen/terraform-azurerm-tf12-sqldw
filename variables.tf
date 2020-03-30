variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "australiaeast"
}

variable "tags" {
  type        = "map"
  description = "A map of the tags to use on the resources that are deployed with this module."
}

variable "sql_dw_name" {
  description = "SQL dw server name"
}

variable "db_name" {
  description = "SQL database name"
}

variable "db_collation" {
  description = "Collation of the database"
  default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_admin_user_name" {
  description = "SQL Admin username of the sqldw"
}
variable "sql_admin_password" {
   description = "Password for the SQL Admin, must comply Azure policy"
}
variable "dwuname" {
   description = "Capacity of the SQLDW"
   default = "dw500c"
}

variable "aad_admin_user_id" {
  description = "AD object id of the administrator"
}

variable "aad_admin_user_name" {
  description = "AD object administrator name"
}

variable "azure_tenant_id" {
  description = "Tenant_id"
}

variable "whitelisted_networks" {
  type = "list"
  description = "A list of rules to be whitelisted from the sqldw firewall, .i.e.: [ { name = 'digitalNetwork' start_ip = '165.225.98.0' end_ip = '165.225.98.255' }]"
}

variable "whitelisted_subnets" {
   type = "list"
   description = "A list of subnet ids to be whiteslisted"
}
