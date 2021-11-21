# mgmt-rt
resource "aws_route_table" "Final_rt_mgmt" {
  vpc_id = aws_vpc.Final_vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.Final_igw.id
  }

  depends_on = [
    aws_internet_gateway.Final_igw
  ]
  tags = {
    Name = "Final-rt-mgmt"
  }
}

# mgmt-rt-ass
resource "aws_route_table_association" "Final_rt_mgmt_ass" {
  subnet_id      = aws_subnet.Final_mgmt_subnet.id
  route_table_id = aws_route_table.Final_rt_mgmt.id
}

# pri-rt
resource "aws_route_table" "Final_rt" {

  count = length(var.zone)
  vpc_id = aws_vpc.Final_vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_nat_gateway.Final_natgw[count.index].id
  }

  tags = {
    Name = "Final-rt-${var.zone[count.index]}"
  }
}

# pri-rt-ass
resource "aws_route_table_association" "Final_rt_web_ass" {
  count          =  length(var.zone)  
  subnet_id      = aws_subnet.Final_web_subnet[count.index].id
  route_table_id = aws_route_table.Final_rt[count.index].id
}

resource "aws_route_table_association" "Final_rt_was_ass" {
  count          =  length(var.zone)  
  subnet_id      = aws_subnet.Final_was_subnet[count.index].id
  route_table_id = aws_route_table.Final_rt[count.index].id
}

/*
## S3 Endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = aws_vpc.Final_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
  
  tags = {
   Name = "final-s3-endpoint"
  }
}
# s3 endpoint rt
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_rt" {
  count           = length(var.zone)
  vpc_endpoint_id = aws_vpc_endpoint.s3_endpoint.id
  route_table_id  = aws_route_table.Final_rt[count.index].id
}
*/