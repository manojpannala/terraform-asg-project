# Call VPC module first to get the Subnet IDs
module "mrp-vpc" {
    source = "../vpc"  
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

