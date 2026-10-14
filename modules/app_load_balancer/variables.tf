variable "project_name" {
  description = "The name of the project."
  type        = string
  default     = "my-project"
}

variable "owner" {
  description = "The owner of the resources."
  type        = string
  default     = "hasanah.adeyanju@qucoon.com"
}

variable "environment" {
  description = "The environment for the resources."
  type        = string
  default     = "development"
}

variable "create_count" {
  description = "The count of Load Balancer being created."
  type        = number
  default     = 1
}

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "A list of availability zones for the subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs."
  type        = list(string)
}

variable "ec2_instance_id" {
  description = "The ID of the EC2 instance to be registered with the target group."
  type        = string
}