# Output the public IP of the instance
output "instance_public_ip" {
  description = "The public IP address of the NGINX instance for this environment."
  value       = module.ec2.public_ip
}
