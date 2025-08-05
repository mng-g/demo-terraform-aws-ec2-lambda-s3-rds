data "terraform_remote_state" "api_lambda" {
  backend = "local"
  config = {
    path = "../api-lambda/terraform.tfstate"
  }
}

data "terraform_remote_state" "network_security" {
  backend = "local"
  config = {
    path = "../network-security/terraform.tfstate"
  }
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = data.terraform_remote_state.network_security.outputs.subnet_ids[0]
  security_group_id   = data.terraform_remote_state.network_security.outputs.security_group_id
  key_name            = "${var.prefix}-key-${terraform.workspace}"
  public_key_path     = "~/.ssh/id_rsa.pub"
  prefix              = var.prefix
  environment         = terraform.workspace
  index_html_template = "src/frontend/index.html.tpl"
  script_js_path      = "src/frontend/script.js"
  api_url             = data.terraform_remote_state.api_lambda.outputs.api_url
}