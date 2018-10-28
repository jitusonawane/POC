#configure provider
provider "aws" {
  region = "${var.region}"
}

# Configuring instance
resource "aws_instance" "app_instance" {
  count                  = "${var.instance_count}"
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  subnet_id              = "${element(aws_subnet.public_subnet.*.id,count.index)}"
  vpc_security_group_ids = ["${aws_security_group.app_security_groups.id}"]
  user_data              = "${file(var.user_data)}"

  tags {
    Name = "Jenkins-Ansible-${count.index}"
  }
}

#Configuring security groups
resource "aws_security_group" "app_security_groups" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.app_vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
