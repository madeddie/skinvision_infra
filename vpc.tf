data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"

  azs             = "${var.vpc_azs}"
  private_subnets = "${var.vpc_private_subnets}"
  public_subnets  = "${var.vpc_public_subnets}"

  enable_nat_gateway      = true
  enable_vpn_gateway      = false
  map_public_ip_on_launch = false
  enable_dns_hostnames    = true
  enable_dns_support      = true

  tags          = {
    Terraform   = "true"
    Environment = "${var.vpc_name}"
  }
}
