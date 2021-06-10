variable "SSH_CIDR_APP" {
    type = string
    default = "0.0.0.0/0"
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

variable "AWS_REGION" {
    type = string
    default = "eu-central-1"
}

variable "ENVIRONMENT" {
    description = "AWS VPC ENVIRONMENT"
    type = string
    default = "development"
}

variable "public_key_path" {
    description = "Public key path"
    default = "~/.ssh/mrp_key.pub"
}

variable "vpc_private_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}


variable "vpc_public_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_public_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}