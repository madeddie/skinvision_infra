variable "environment" { default = "dev" }
variable "region"      { default = "eu-west-1" }

variable "vpc_name"            { default = "dev" }
variable "vpc_cidr"            { default = "10.0.0.0/16" }
variable "vpc_azs"             { default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"] }
variable "vpc_private_subnets" { default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] }
variable "vpc_public_subnets"  { default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"] }

variable "openvpn_password"      { default = "0p3nvpn_p4ssw0rd" }
variable "openvpn_instance_type" { default = "t2.micro" }
variable "openvpn_az"            { default = "eu-west-1a" }
variable "openvpn_key_name"      { default = "default" }
