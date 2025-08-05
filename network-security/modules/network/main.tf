resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.prefix}-vpc-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "this" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.prefix}-subnet-${count.index + 1}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.prefix}-igw-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "${var.prefix}-route-table-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = 2
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.public_rt.id
}
