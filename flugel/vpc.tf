resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.vpc_public_subnet_bitmask, var.vpc_public_subnet_start)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${var.vpc_name}"
  }
}

resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = "Public-route-table-${var.vpc_name}"
    },

  )
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = "internet-gateway-${var.vpc_name}"
    },

  )
}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  #   timeouts {
  #     create = "5m"
  #   }
}

resource "aws_route_table_association" "public" {

  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

