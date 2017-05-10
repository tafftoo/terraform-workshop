# Define the public routing table
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

# Define the private route table
resource "aws_route_table" "private" {
    vpc_id = "${aws_vpc.my_vpc.id}"

    tags {
        Name = "Private Route Table"
    }
}

# Define the private route
resource "aws_route" "private_route" {
    route_table_id = "${aws_route_table.private.id}"
    gateway_id = "${aws_nat_gateway.nat_gw.id}"

    destination_cidr_block = "0.0.0.0/0"
}

# Associate the private subnet with the private routing table
resource "aws_route_table_association" "private" {
    subnet_id = "${aws_subnet.private.id}"
    route_table_id = "${aws_route_table.private.id}"
}
