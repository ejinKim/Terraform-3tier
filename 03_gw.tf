# igw
resource "aws_internet_gateway" "Final_igw" {
  vpc_id = aws_vpc.Final_vpc.id

  tags = {
    Name = "Final-igw"
  }
}

#ngw
resource "aws_eip" "Final_nat_eip" {
  count = length(var.zone)
  vpc      = true
}

resource "aws_nat_gateway" "Final_natgw" {
  count = length(var.zone)
  allocation_id = aws_eip.Final_nat_eip[count.index].id
  subnet_id     = aws_subnet.Final_pub_subnet[count.index].id

  tags = {
    Name = "Final-natgw-${var.zone[count.index]}"
  }
}