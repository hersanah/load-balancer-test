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

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.11.0/24"]
}

variable "private_subnets" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.12.0/24"]
}