output "load_balancer_1_dns_name" {
  value = module.app_load_balancer_1.lb_dns_name
}

output "load_balancer_2_dns_name" {
  value = module.app_load_balancer_2.lb_dns_name
}

output "web_server_1_instance_id" {
  value = module.web_server_1.web_server_id
}

output "web_server_2_instance_id" {
  value = module.web_server_2.web_server_id
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "ec2_connect_endpoint_id" {
  value = module.networking.ec2_connect_endpoint_id
}
