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

# Define Security Group for the App
resource "aws_security_group" "mrp_app" {
    tags = {
        Name = "${var.ENVIRONMENT}-mrp-app"
    }

    name = "${var.ENVIRONMENT}-mrp-app"
    description = "Created by MRP"
    vpc_id = module.mrp_vpc.my_vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.SSH_CIDR_APP}"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Resource Key-Pair
resource "aws_key_pair" "mrp_key" {
    key_name = "mrp_key"  
    public_key = file(var.public_key_path)
}

