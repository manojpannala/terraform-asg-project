provider "aws" {
    region = var.AWS_REGION  
}

module "mrp_vpc" {
    source = "./module/vpc"  

    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

module "mrp_app" {
    source = "./app"
    
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION  = var.AWS_REGION
    vpc_private_subnet1 = module.mrp-vpc.mrp_vpc_private_subnet_1
    vpc_private_subnet2 = module.mrp-vpc.mrp_vpc_private_subnet_2
    vpc_id = module.mrp-vpc.my_vpc_id
    vpc_public_subnet1 = module.mrp-vpc.mrp_vpc_public_subnet_1
    vpc_public_subnet2 = module.mrp-vpc.mrp_vpc_public_subnet_2
}

output "load_balancer_output" {
  description = "Load Balancer"
  value       = module.mrp-app.load_balancer_output
}