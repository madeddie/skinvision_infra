data "aws_ami" "openvpn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["OpenVPN Access Server *fe8020db-5343-4c43-9e65-5ed4a825c931*"] # BYOL version of OpenVPN AS AMI
  }

  owners = ["679593333241"] # OpenVPN.net
}

resource "aws_security_group" "openvpn" {
  name            = "openvpn"
  description     = "Allow openvpn and ssh inbound traffic"
  vpc_id          = "${module.vpc.vpc_id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = ["${module.vpc.default_security_group_id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 943
    to_port     = 943
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "openvpn" {
  ami                         = "${data.aws_ami.openvpn.id}"
  instance_type               = "${var.openvpn_instance_type}"
  availability_zone           = "${data.aws_availability_zones.available.names[0]}"
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  vpc_security_group_ids      = ["${aws_security_group.openvpn.id}", "${module.vpc.default_security_group_id}"]
  associate_public_ip_address = true
  key_name                    = "${var.openvpn_key_name}"
  user_data                   = "admin_user=${var.openvpn_username}\nadmin_pw=${var.openvpn_password}"

  tags {
    Name = "openvpn-${terraform.env}"
  }
}

output "openvpn_address" {
  value = "${aws_instance.openvpn.public_ip}"
}
