variable "AWS_REGION" {
    type = string
    default = "eu-central-1"
}

variable "ENVIRONMENT" {
    description = "AWS VPC ENVIRONMENT"
    type = string
    default = "development"
}

variable "INSTANCE_TYPE" {
    default = "t2.micro" 
}

variable "AMIS" {
    type = map
    default = {
        eu-central-1 = "ami-0980c5102b5ef10cc",
        eu-west-1 = "ami-06c5b2809791cf59c"
    }
}