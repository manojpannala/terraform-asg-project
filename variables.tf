variable "AWS_REGION" {
    type = string
    default = "eu-central-1"
}

variable "ENVIRONMENT" {
    description = "AWS VPC ENVIRONMENT"
    type = string
    default = "Development"
}