variable "AWS_REGION" {
    default = "eu-central-1"
    type = string
}

variable "VPC_CIDR_BLOCK" {
    default = "10.0.0.0/16"
    type = string
    description = "The CIDR block for VPC"
}

variable "ENVIRONMENT" {
    default = ""
    type = string
    description = "VPC ENVIRONMENT"
}

variable "VPC_PUBLIC_SUBNET_1_CIDR" {
    default = "10.0.101.0/24"
    type = string
    description = "The CIDR block for VPC"
}

variable "VPC_PUBLIC_SUBNET_2_CIDR" {
    default = "10.0.102.0/24"
    type = string
    description = "The CIDR block for VPC"
}

variable "VPC_PRIVATE_SUBNET_1_CIDR" {
    default = "10.0.1.0/24"
    type = string
    description = "The CIDR block for VPC"
}

variable "VPC_PRIVATE_SUBNET_2_CIDR" {
    default = "10.0.2.0/24"
    type = string
    description = "The CIDR block for VPC"
}