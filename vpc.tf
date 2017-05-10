# Some Variable definitions
variable "cidr_vpc" { default = "192.168.25.0/24" }
variable "cidr_subnet_public" { default = "192.168.25.0/26" }
variable "cidr_subnet_private" { default = "192.168.25.64/26" }
variable "cidr_subnet_database" { default = "192.168.25.128/26" }

# Define the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "${var.cidr_vpc}"

  tags {
    Name = "My VPC"
  }
}

# Define the Internet Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.my_vpc.id}"

    tags {
        Name = "My VPC IGW"
    }
}

# Define a Public Subnet
resource "aws_subnet" "public" {

    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "${var.cidr_subnet_public}"

    map_public_ip_on_launch = true

    tags {
      Name = "Public subnet"
    }
}

# Define a Private Subnet
resource "aws_subnet" "private" {

    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "${var.cidr_subnet_private}"

    tags {
      Name = "Private subnet"
    }
}

# Define another private subnet for database
resource "aws_subnet" "database" {

    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "${var.cidr_subnet_database}"

    tags {
      Name = "Database subnet"
    }
}
