output "sqlserver_name" {
  value = "${azurerm_sql_server.sqldw_server.fully_qualified_domain_name}"
}

output "objectId" {
  value = "${azurerm_sql_server.sqldw_server.identity.0.principal_id}"
}

output "sqldw_id" {
  value = "${azurerm_sql_database.sqldw_db.id}"
}

output "sqlsvr_id" {
  value = "${azurerm_sql_server.sqldw_server.id}"
}