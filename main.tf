module "mrp_vpc" {
    source = "./app"  
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

provider "aws" {
    region = var.AWS_REGION  
}