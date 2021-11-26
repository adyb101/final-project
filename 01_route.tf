# Internet gateway
resource "aws_internet_gateway" "pro_ig" {
  vpc_id = aws_vpc.pro_vpc.id

  tags = {
    "Name" = "pro-tf-ig"
  }
}

# Route table
resource "aws_route_table" "pro_rt" {
  vpc_id = aws_vpc.pro_vpc.id

  route {
  #  carrier_gateway_id = "value"
    cidr_block = "0.0.0.0/0"
  #  destination_prefix_list_id = "value"
  #  egress_only_gateway_id = "value"
    gateway_id = aws_internet_gateway.pro_ig.id
  #  instance_id = "value"
  #  ipv6_cidr_block = "value"
  #  local_gateway_id = "value"
  #  nat_gateway_id = "value"
  #  network_interface_id = "value"
  #  transit_gateway_id = "value"
  #  vpc_endpoint_id = "value"
  #  vpc_peering_connection_id = "value"
  } 
  tags = {
    Name = "pro-tf-rt"
  }
}

# Route table association
resource "aws_route_table_association" "pro_rtas_a" {
  subnet_id = aws_subnet.pro_puba.id
  route_table_id = aws_route_table.pro_rt.id
}

resource "aws_route_table_association" "pro_rtas_c" {
  subnet_id = aws_subnet.pro_pubc.id
  route_table_id = aws_route_table.pro_rt.id
}

# EIP_Nat gateway
resource "aws_eip" "lb_ip" {
  #instance = aws_instance.web.id
  vpc   = true
}

# Nat gateway
resource "aws_nat_gateway" "pro_nga" {
  allocation_id = aws_eip.lb_ip.id
  subnet_id     = aws_subnet.pro_puba.id

  tags = {
    "Name" = "pro-tf-nat"
  }
}

# Nat gateway route table
resource "aws_route_table" "pro_ngart_a" {
    vpc_id = aws_vpc.pro_vpc.id
    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_nat_gateway.pro_nga.id
    }

    tags = {
      "Name" = "pro-tf-nat-rt"
    }
}

# Nat gateway route table association
resource "aws_route_table_association" "pro_ngartas_a" {
    subnet_id = aws_subnet.pro_pria.id
    route_table_id = aws_route_table.pro_ngart_a.id    
}

resource "aws_route_table_association" "pro_ngartas_c" {
    subnet_id = aws_subnet.pro_pric.id
    route_table_id = aws_route_table.pro_ngart_a.id    
}
