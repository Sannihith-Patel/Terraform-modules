resource "aws_eip" "ngw_eip" {
  domain = "vpc"
  tags = merge(
    { Name = "${var.vpc_name}-eip-${var.unique_string}" },
    var.tags
  )
}

resource "aws_nat_gateway" "vpc_ngw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = merge(
    { Name = "${var.vpc_name}-ngw-${var.unique_string}" },
    var.tags
  )
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.vpc_name}-igw-${var.unique_string}" },
    var.tags
  )
}