locals {
  sql_server_name = "${var.sql_dw_name == "" ? format("%s-df", random_string.id.result) : var.sql_dw_name}"
}

resource "azurerm_sql_server" "sqldw_server" {
  name                         = "${local.sql_server_name}"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "${var.sql_admin_user_name}"
  administrator_login_password = "${var.sql_admin_password}"
  tags                         = "${var.tags}"
  identity                     = {
    type = "SystemAssigned"
  }
}

resource "azurerm_sql_database" "sqldw_db" {
  name                             = "${var.db_name == "" ? format("%s-df", random_string.id.result) : var.db_name}"
  resource_group_name              = "${var.resource_group_name}"
  server_name                      = "${azurerm_sql_server.sqldw_server.name}"
  location                         = "${var.location}"
  edition                          = "DataWarehouse"
  collation                        = "${var.db_collation}"
  requested_service_objective_name = "${var.dwuname}"

  tags = "${var.tags}"
}

resource "azurerm_sql_active_directory_administrator" "sqldw_aad" {
  server_name         = "${azurerm_sql_server.sqldw_server.name}"
  resource_group_name = "${var.resource_group_name}"
  login               = "${var.aad_admin_user_name}"
  tenant_id           = "${var.azure_tenant_id}"
  object_id           = "${var.aad_admin_user_id}"
}

resource "azurerm_sql_firewall_rule" "sqldw_fw_rules" {
  count               = "${length(var.whitelisted_networks)}"
  name                = "${lookup(var.whitelisted_networks[count.index],"name")}"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.sqldw_server.name}"
  start_ip_address    = "${lookup(var.whitelisted_networks[count.index],"start_ip")}"
  end_ip_address      = "${lookup(var.whitelisted_networks[count.index],"end_ip")}"
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
  count               = "${length(var.whitelisted_subnets)}"
  name                = "sql-vnet-rule${count.index}"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.sqldw_server.name}"
  subnet_id           = "${var.whitelisted_subnets[count.index]}"
}

resource "random_string" "id" {
  length  = "8"
  upper   = false
  special = false
  number  = false
}
