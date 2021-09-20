resource "aws_security_group" "http_from_internet" {
  name        = var.sg_traffic_for_internet.name
  description = var.sg_traffic_for_internet.description
  vpc_id      = aws_vpc.main.id

  ingress = var.sg_traffic_for_internet.ingress

  egress = [var.sg_default_egress]

  tags = {
    Name = var.sg_traffic_for_internet.name
  }
}

resource "aws_security_group" "http_from_lb" {
  name        = var.sg_traffic_for_vpc.name
  description = var.sg_traffic_for_vpc.description
  vpc_id      = aws_vpc.main.id

  ingress = var.sg_traffic_for_vpc.ingress

  egress = [var.sg_default_egress]

  tags = {
    Name = var.sg_traffic_for_vpc.name
  }
}