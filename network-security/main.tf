module "network" {
  source       = "./modules/network"
  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  azs          = var.azs
  prefix       = var.prefix
  environment  = terraform.workspace
}

module "security" {
  source      = "./modules/security"
  vpc_id      = module.network.vpc_id
  vpc_cidr    = var.vpc_cidr
  prefix      = var.prefix
  environment = terraform.workspace
}