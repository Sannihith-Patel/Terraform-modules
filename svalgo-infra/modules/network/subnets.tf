resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    { Name = "${var.vpc_name}-public-Subnet-${data.aws_availability_zones.available.names[count.index]}-${var.unique_string}" },
    { VPC = "${aws_vpc.vpc.id}" },
    var.tags
  )
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    { Name = "${var.vpc_name}-private-subnet-${data.aws_availability_zones.available.names[count.index]}-${var.unique_string}" },
    { VPC = "${aws_vpc.vpc.id}" },
    var.tags
  )
}