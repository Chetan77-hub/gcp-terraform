provider "google" {
  project = var.project_id
  region  = var.region
}
module "vpc" {
  source            = "./modules/vpc"
  vpc_name          = "custom-vpc"
  region            = var.region
  secondary_region  = var.secondary_region
}

module "compute" {
  source          = "./modules/compute"
  vpc_id          = module.vpc.vpc_id
  zone            = var.zone
  public_subnet   = module.vpc.public_subnet
  private_subnet  = module.vpc.private_vm_subnet
}

module "sql" {
  source     = "./modules/sql"
  vpc_id     = module.vpc.vpc_id
  db_region  = var.secondary_region
  vpc_self_link = module.vpc.vpc_self_link
}
