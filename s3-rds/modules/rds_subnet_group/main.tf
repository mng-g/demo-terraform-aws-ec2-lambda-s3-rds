resource "aws_db_subnet_group" "this" {
  name       = lower(replace("${var.prefix}-dbsubnet-${var.environment}", "_", "-"))
  subnet_ids = var.subnet_ids
  tags = {
    Name        = "${var.prefix}-dbsubnet-${var.environment}"
    Environment = var.environment
  }
}


