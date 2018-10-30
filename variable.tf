variable "region" {
  description = "Choose your region "
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "Enter your vpc_cidr"
  default     = "172.20.0.0/16"
}

variable "instance_tenancy" {
  description = "Choose your instance tenancy default or dedicated"
  default     = "default"
}

variable "public_subnet_cidr" {
  type    = "list"
  default = ["172.20.10.0/24"]
}

variable "private_subnet_cidr" {
  type    = "list"
  default = ["172.20.20.0/24"]
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
  default = "my_demo_key"
}

variable "user_data" {
  default = "./scripts/userdata.sh"
}

#configuring app instance variable
variable "app_instance_count" {
  default = 1
}
