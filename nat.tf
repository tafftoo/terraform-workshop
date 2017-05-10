# Define a NAT Gateway in our public subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_gw.id}"      # Elastic IP defined below
  subnet_id = "${aws_subnet.public.id}"       # The public subnet (where the NAT_GW will live)
  depends_on = ["aws_internet_gateway.gw"]
}

# Define an elastic ip
resource "aws_eip" "nat_gw" {
  vpc = true
}
