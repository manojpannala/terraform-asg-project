# Call VPC module first to get the Subnet IDs
module "mrp-vpc" {
    source = "../vpc"  
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

# Define Subnet Group for RDS Service
resource "aws_db_subnet_group" "mrp-rds-subnet-group" {
    name = "${var.ENVIRONMENT}-mrp-rds-db"  
    description = "Allowed subnets for DB cluster instances"
    subnet_ids = [ 
        "${module.mrp_vpc_private_subnet_1}",
        "${module.mrp_vpc_private_subnet_2}" 
    ]
    tags = {
        Name = "${var.ENVIRONMENT}-mrp-db-subnet"
    }
}

