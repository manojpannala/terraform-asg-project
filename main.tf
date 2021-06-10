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
    vpc_private_subnet1 = module.mrp_vpc.private_subnet_1_id
    vpc_private_subnet2 = module.mrp_vpc.private_subnet_2_id
    vpc_id = module.mrp_vpc.my_vpc_id
    vpc_public_subnet1 = module.mrp_vpc.public_subnet_1_id
    vpc_public_subnet2 = module.mrp_vpc.public_subnet_2_id
}

output "load_balancer_output" {
  description = "Load Balancer"
  value       = module.mrp_app.load_balancer_output
}