# PLANTED MISCONFIGURATIONS — see test-infra/README.md

resource "aws_db_instance" "primary" {
  identifier        = "auditbridge-demo-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "auditbridge"
  username          = "app_admin"
  password          = var.db_password

  # (9) Encryption — data at rest is not encrypted.
  storage_encrypted = false

  # (10) Network exposure — publicly reachable database.
  publicly_accessible = true

  skip_final_snapshot = true
}
