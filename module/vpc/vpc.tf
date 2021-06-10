data "aws_availability_zones" "available" {
    state = "available"  
}

# Main VPC

resource "aws_vpc" "mrp_vpc" {
    cidr_block = var.VPC_CIDR_BLOCK  
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.ENVIRONMENT}-vpc"
    }
}

# Public Subnets

# Public-Subnet-1
resource "aws_subnet" "mrp_vpc_public_subnet_1" {
    vpc_id = aws_vpc.mrp_vpc.id  
    cidr_block = var.VPC_PUBLIC_SUBNET_1_CIDR
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.ENVIRONMENT}-mrp_vpc_public_subnet_1"
    }
}

# Public-Subnet-2
resource "aws_subnet" "mrp_vpc_public_subnet_2" {
    vpc_id = aws_vpc.mrp_vpc.id  
    cidr_block = var.VPC_PUBLIC_SUBNET_2_CIDR
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.ENVIRONMENT}-mrp_vpc_public_subnet_2"
    }
}

# Private Subnets

# Private-Subnet-1
resource "aws_subnet" "mrp_vpc_private_subnet_1" {
    vpc_id = aws_vpc.mrp_vpc.id  
    cidr_block = var.VPC_PRIVATE_SUBNET_1_CIDR
    availability_zone = data.aws_availability_zones.available.names[0]
    # map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.ENVIRONMENT}-mrp_vpc_private_subnet_1"
    }
}

# Private-Subnet-2
resource "aws_subnet" "mrp_vpc_private_subnet_2" {
    vpc_id = aws_vpc.mrp_vpc.id  
    cidr_block = var.VPC_PRIVATE_SUBNET_2_CIDR
    availability_zone = data.aws_availability_zones.available.names[0]
    # map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.ENVIRONMENT}-mrp_vpc_private_subnet_2"
    }
}
