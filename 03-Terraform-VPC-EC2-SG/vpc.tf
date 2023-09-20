module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name = "${local.name}-VPC"
  cidr = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0,2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"]
  map_public_ip_on_launch = true
  enable_nat_gateway = true
  single_nat_gateway = true
#   enable_vpn_gateway = true
  tags = local.common_tags
}