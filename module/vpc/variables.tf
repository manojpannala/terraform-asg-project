variable "VPC_CIDR_BLOCK" {
    default = "10.0.0.0/16"
}

variable "ENVIRONMENT" {
    default = ""
    type = string
}

variable "VPC_PUBLIC_SUBNET_1_CIDR" {
    default = "10.0.1.0/24"
}

variable "VPC_PUBLIC_SUBNET_2_CIDR" {
    default = "10.0.2.0/24"
}