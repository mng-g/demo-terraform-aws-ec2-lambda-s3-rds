resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)

  tags = {
    Name        = var.key_name
    Environment = var.environment
  }
}

resource "aws_instance" "nginx" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.this.key_name

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -e
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx

              sudo rm /usr/share/nginx/html/index.html
              cat <<'EOT' > /usr/share/nginx/html/index.html
              ${replace(templatefile(var.index_html_template, { env = var.environment, api_url = var.api_url }), "__ENV__", var.environment)}
              EOT
              cat <<'EOT' > /usr/share/nginx/html/script.js
              ${file(var.script_js_path)}
              EOT

              sudo systemctl restart nginx
              EOF

  tags = {
    Name        = "${var.prefix}-nginx-instance-${var.environment}"
    Environment = var.environment
  }

  iam_instance_profile = var.iam_instance_profile
}

