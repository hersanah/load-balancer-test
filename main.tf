terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "networking" {
    source = "./modules/networking"
    project_name = var.project_name
    owner = var.owner
    environment = var.environment
    region = var.region
    availability_zones = var.availability_zones
    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
}

module "web_server_1" {
    source = "./modules/web_server"
    project_name = var.project_name
    owner = var.owner
    environment = var.environment
    create_count = 1
    region = var.region
    availability_zones = var.availability_zones
    vpc_id = module.networking.vpc_id
    subnet_ids = module.networking.private_subnet_ids
    lb_sg_id = module.app_load_balancer_1.lb_sg_id
    ec2_connect_endpoint_sg_id = module.networking.ec2_connect_sg_id
}

module "web_server_2" {
    source = "./modules/web_server"
    project_name = var.project_name
    owner = var.owner
    environment = var.environment
    create_count = 2
    region = var.region
    availability_zones = var.availability_zones
    vpc_id = module.networking.vpc_id
    subnet_ids = module.networking.private_subnet_ids
    lb_sg_id = module.app_load_balancer_2.lb_sg_id
    ec2_connect_endpoint_sg_id = module.networking.ec2_connect_sg_id
}

module "app_load_balancer_1" {
    source = "./modules/app_load_balancer"
    project_name = var.project_name
    owner = var.owner
    environment = var.environment
    create_count = 1
    region = var.region
    availability_zones = var.availability_zones
    vpc_id = module.networking.vpc_id
    public_subnet_ids = module.networking.public_subnet_ids
    ec2_instance_id = module.web_server_1.web_server_id
}

module "app_load_balancer_2" {
    source = "./modules/app_load_balancer"
    project_name = var.project_name
    owner = var.owner
    environment = var.environment
    create_count = 2
    region = var.region
    availability_zones = var.availability_zones
    vpc_id = module.networking.vpc_id
    public_subnet_ids = module.networking.public_subnet_ids
    ec2_instance_id = module.web_server_2.web_server_id
}