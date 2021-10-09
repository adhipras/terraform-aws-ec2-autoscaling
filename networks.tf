#-------------------------------------------------------------------------------
# Virtual Private Cloud (VPC)
#-------------------------------------------------------------------------------

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    "Name" = "vpc-main"
  }
}

#-------------------------------------------------------------------------------
# Public Subnetwork
#-------------------------------------------------------------------------------

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet-public"
  }
}

#-------------------------------------------------------------------------------
# Private Subnetworks
#-------------------------------------------------------------------------------

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zone
  cidr_block              = var.private_subnet_cidr_block
  map_public_ip_on_launch = false

  tags = {
    "Name" = "subnet-private"
  }
}

#-------------------------------------------------------------------------------
# Internet Gateway
#-------------------------------------------------------------------------------

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "interget-gateway"
  }
}

resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }

  tags = {
    Name = "route-internet"
  }
}

resource "aws_route_table_association" "internet" {
  route_table_id = aws_route_table.internet.id
  subnet_id      = aws_subnet.public.id
}

#-------------------------------------------------------------------------------
# NAT Gateway
#-------------------------------------------------------------------------------

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.internet]
  vpc        = true

  tags = {
    Name = "eip-nat-gateway"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public.id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "nat-gateway"
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "route-nat"
  }
}

resource "aws_route_table_association" "nat" {
  route_table_id = aws_route_table.nat.id
  subnet_id      = aws_subnet.private.id
}
