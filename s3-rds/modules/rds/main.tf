resource "aws_db_instance" "this" {
  identifier              = lower(replace("${var.prefix}-rds-${var.environment}", "_", "-"))
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "17.5"
  instance_class          = "db.t3.micro"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = 5432
  publicly_accessible     = false
  vpc_security_group_ids  = [var.security_group_id]
  db_subnet_group_name    = var.db_subnet_group_name
  skip_final_snapshot     = true
  multi_az                = false
  storage_encrypted       = false
  auto_minor_version_upgrade = true

  tags = {
    Name        = "${var.prefix}-rds-${var.environment}"
    Environment = var.environment
  }
}
