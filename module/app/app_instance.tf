module "mrp_vpc" {
    source = "../module/vpc"
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

module "mrp_rds" {
    source = "../module/rds"
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

