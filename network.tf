# Configure data availability_zone
data "aws_availability_zones" "available" {}

# configuring vpc
resource "aws_vpc" "app_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.instance_tenancy}"

  tags {
    Name = "app_vpc"
  }
}

# configuring public subnet
resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.public_subnet_cidr)}"
  vpc_id                  = "${aws_vpc.app_vpc.id}"
  cidr_block              = "${var.public_subnet_cidr[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "public_subnet-${count.index}"
  }
}

# configuring private subnet
resource "aws_subnet" "private_subnet" {
  count             = "${length(var.private_subnet_cidr)}"
  vpc_id            = "${aws_vpc.app_vpc.id}"
  cidr_block        = "${var.private_subnet_cidr[count.index]}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "private_subnet-${count.index}"
  }
}

# Configuring internet gateway
resource "aws_internet_gateway" "app_igw" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  tags {
    Name = "app_igw"
  }
}

# Configuring Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.app_igw.id}"
  }

  tags {
    Name = "public_route_table"
  }
}

# Configuring Route Table association
resource "aws_route_table_association" "sub_route_asso" {
  count          = "${length(var.public_subnet_cidr)}"
  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
