variable "region" {
  description = "Choose your region "
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "Enter your vpc_cidr"
  default     = "10.20.0.0/16"
}

variable "instance_tenancy" {
  description = "Choose your instance tenancy default or dedicated"
  default     = "default"
}

variable "private_subnet_cidr" {
  type    = "list"
  default = ["10.20.0.0/24"]
}

variable "public_subnet_cidr" {
  type    = "list"
  default = ["10.20.2.0/24"]
}

# configuring instance variables

variable "instance_count" {
  default = 1
}

variable "ami" {
  default = "ami-28e07e50"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "west"
}

variable "user_data" {
  default = "./scripts/userdata.sh"
}
