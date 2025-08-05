data "terraform_remote_state" "network_security" {
  backend = "local"
  config = {
    path = "../network-security/terraform.tfstate"
  }
}

# S3 Bucket module
module "s3" {
  source      = "./modules/s3"
  prefix      = var.prefix
  environment = terraform.workspace
  aws_region  = var.aws_region
}

# S3 VPC Endpoint for Lambda access to S3 from private subnets
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = data.terraform_remote_state.network_security.outputs.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = data.terraform_remote_state.network_security.outputs.route_table_ids

  tags = {
    Name = "${var.prefix}-s3-endpoint"
  }
}

# RDS Subnet Group (using the same subnet as the network module for simplicity)
module "rds_subnet_group" {
  source      = "./modules/rds_subnet_group"
  prefix      = var.prefix
  environment = terraform.workspace
  subnet_ids  = data.terraform_remote_state.network_security.outputs.subnet_ids
}

# RDS PostgreSQL instance
module "rds" {
  source               = "./modules/rds"
  prefix               = var.prefix
  environment          = terraform.workspace
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  security_group_id    = data.terraform_remote_state.network_security.outputs.security_group_id
  db_subnet_group_name = module.rds_subnet_group.db_subnet_group_name
}