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
        "${module.private_subnet_1_id}",
        "${module.private_subnet_2_id}" 
    ]
    tags = {
        Name = "${var.ENVIRONMENT}-mrp-db-subnet"
    }
}

# Define Security Groups for RDS Instances
resource "aws_security_group" "mrp-rds-sg" {
    name = "${var.ENVIRONMENT}-mrp-rds-sg"  
    description = "SG for RDS"
    vpc_id = module.mrp_vpc.my_vpc_id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_block = ["${var.RDS_CIDR}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_block = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.ENVIRONMENT}-mrp-rds-sg"
    }
}