# Some Variable definitions
variable "cidr_vpc" { default = "192.168.25.0/24" }
variable "cidr_subnet_public" { default = "192.168.25.0/26" }

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

    tags {
      Name = "Public subnet"
    }
}

# Define a routing table
resource "aws_route_table" "public" {
    vpc_id = "${aws_vpc.my_vpc.id}"

    tags {
        Name = "Public Route Table"
    }
}

# Define the public route
resource "aws_route" "public_route" {
    route_table_id = "${aws_route_table.public.id}"
    gateway_id = "${aws_internet_gateway.gw.id}"

    destination_cidr_block = "0.0.0.0/0"
}

# Associate the subnet with the routing table
resource "aws_route_table_association" "public" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.public.id}"
}
