provider "aws" {
  region = var.aws_region
}

# Networking Module
module "networking" {
  source              = "./modules/networking"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr

}

# Security Groups Module
module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.networking.vpc_id
}

# EC2 Instances Module
module "ec2_instances" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  public_subnet_id  = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  public_sg         = module.security_groups.public_sg_id
  private_sg        = module.security_groups.private_sg_id
}

module "network_acl" {
  source = "./modules/networking"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidr  = var.private_subnet_cidr
}