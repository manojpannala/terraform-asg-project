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