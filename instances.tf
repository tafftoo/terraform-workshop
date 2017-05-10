variable "instance_type" { default = "t2.micro" }
variable "instance_ami"  { default = "ami-01ccc867" } # Amazon Linux
variable "key_name"      { description = "The name of the ssh key" }

resource "aws_instance" "public_instance" {
  ami           = "${var.instance_ami}"
  key_name      = "${var.key_name}"
  subnet_id     = "${aws_subnet.public.id}"
  instance_type = "${var.instance_type}"

  root_block_device {
      volume_type           = "gp2"
      volume_size           = 8
      delete_on_termination = true
  }

  tags {
    Name = "Public Instance"
  }
}

resource "aws_instance" "private_instance" {
  ami           = "${var.instance_ami}"
  key_name      = "${var.key_name}"
  subnet_id     = "${aws_subnet.private.id}"
  instance_type = "${var.instance_type}"

  root_block_device {
      volume_type           = "gp2"
      volume_size           = 8
      delete_on_termination = true
  }

  tags {
    Name = "Private Instance"
  }
}

resource "aws_instance" "database_instance" {
  ami           = "${var.instance_ami}"
  key_name      = "${var.key_name}"
  subnet_id     = "${aws_subnet.database.id}"
  instance_type = "${var.instance_type}"

  root_block_device {
      volume_type           = "gp2"
      volume_size           = 8
      delete_on_termination = true
  }

  tags {
    Name = "Database Instance"
  }
}
