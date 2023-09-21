## EIP FOR NAT
resource "aws_eip" "nat_eip" {
  count      = var.enable_nat_gateway ? length(var.availability_zones) : 0
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}
## NAT GATEWAY
resource "aws_nat_gateway" "nat" {
  count         = var.enable_nat_gateway ? length(var.availability_zones) : 0
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)
  depends_on    = [aws_internet_gateway.ig]
  tags = {
    Name        = "${var.environment}-nat-${count.index}"
    Environment = "${var.environment}"
  }
}
