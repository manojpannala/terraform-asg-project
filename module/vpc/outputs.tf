output "my_vpc_id" {
    description = "VPC ID"  
    value = aws_vpc.mrp_vpc.id
}

output "private_subnet_1_id" {
    description = "Private Subnet 1 ID"  
    value = aws_subnet.mrp_vpc_private_subnet_1.id
}

output "private_subnet_2_id" {
    description = "Private Subnet 2 ID"  
    value = aws_subnet.mrp_vpc_private_subnet_2.id
}

output "public_subnet_1_id" {
    description = "Public Subnet 1 ID"  
    value = aws_subnet.mrp_vpc_public_subnet_1.id
}

output "public_subnet_2_id" {
    description = "Public Subnet 2 ID"  
    value = aws_subnet.mrp_vpc_public_subnet_2.id
}