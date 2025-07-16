resource "google_sql_database_instance" "default" {
  name             = "app-db"
  region           = var.db_region
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }
}
