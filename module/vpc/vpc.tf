provider "aws" {
    region = var.AWS_REGION
}

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
    availability_zone = data.aws_availability_zones.available.names[1]
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
    availability_zone = data.aws_availability_zones.available.names[1]
    # map_public_ip_on_launch = true
    
    tags = {
        Name = "${var.ENVIRONMENT}-mrp_vpc_private_subnet_2"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "mrp-igw" {
    vpc_id = aws_vpc.mrp_vpc.id

    tags = {
       Name = "${var.ENVIRONMENT}-mrp-igw"
    }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "mrp-nat-eip" {
    vpc = true
    depends_on = [
      aws_internet_gateway.mrp-igw
    ]  
}

# NAT Gateway for Private IP 
resource "aws_nat_gateway" "mrp-ngw" {
    allocation_id =   aws_eip.mrp-nat-eip.id
    subnet_id = aws_subnet.mrp_vpc_public_subnet_1.id
    depends_on = [
      aws_internet_gateway.mrp-igw
    ]

    tags = {
        Name = "${var.ENVIRONMENT}-mrp-vpc-nat-gateway"
    }
}

# Route Table for Public Architecture
resource "aws_route_table" "public-rtb" {
    vpc_id = aws_vpc.mrp_vpc.id
    route =  {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mrp-igw.id
    } 

    tags = {
        Name = "${var.ENVIRONMENT}-public-rtb"
    }
}

# Route Table for Private Architecture
resource "aws_route_table" "private-rtb" {
    vpc_id = aws_vpc.mrp_vpc.id
    route =  {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.mrp-ngw.id
    } 

    tags = {
        Name = "${var.ENVIRONMENT}-private-rtb"
    }
}

# Route Table Association with Public Subnets
resource "aws_route_table_association" "to_public_subnet_1" {
    subnet_id = aws_subnet.mrp_vpc_public_subnet_1.id
    route_table_id = aws_route_table.public-rtb.id
}
resource "aws_route_table_association" "to_public_subnets_2" {
    subnet_id = aws_subnet.mrp_vpc_public_subnet_2.id
    route_table_id = aws_route_table.public-rtb.id
}

# Route Table Association with Private Subnets
resource "aws_route_table_association" "to_private_subnets_1" {
    subnet_id = aws_subnet.mrp_vpc_private_subnet_1.id
    route_table_id = aws_route_table.private-rtb.id
}
resource "aws_route_table_association" "to_private_subnets_2" {
    subnet_id = aws_subnet.mrp_vpc_private_subnet_2.id
    route_table_id = aws_route_table.private-rtb.id
}