resource "aws_vpc" "use1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.orgnization}-${var.environment}-vpc"
  }     
}

resource "aws_subnet" "use1subnet1" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr[0]
  availability_zone = var.az[0]
  tags = {
    Name = "${var.orgnization}-${var.environment}-pubsubnet-${var.az[0]}"
  }
}

resource "aws_subnet" "use1subnet2" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr[1]
  availability_zone = var.az[1]
  tags = {
    Name = "${var.orgnization}-${var.environment}-pubsubnet-${var.az[1]}"
  }
}

resource "aws_subnet" "use1subnet3" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr[2]
  availability_zone = var.az[0]
  tags = {
    Name = "${var.orgnization}-${var.environment}-privsubnet-${var.az[0]}"
  }
}

resource "aws_subnet" "use1subnet4" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr[3]
  availability_zone = var.az[1]
  tags = {
    Name = "${var.orgnization}-${var.environment}-privsubnet-${var.az[1]}"
  }
}

resource "aws_internet_gateway" "use1igw" {
  vpc_id = aws_vpc.use1.id
  tags = {
    Name = "${var.orgnization}-${var.environment}-igw"
  }
}   

resource "aws_eip" "use1natgweip" {
  domain   = "vpc"
    tags = {
        Name = "${var.orgnization}-${var.environment}-natgweip"
    }
}

resource "aws_nat_gateway" "use1natgw" {
  allocation_id = aws_eip.use1natgweip.id
  connectivity_type = "public"
  subnet_id = aws_subnet.use1subnet1.id
  tags = {
    Name = "${var.orgnization}-${var.environment}-natgw"
  }
}

resource "aws_route_table" "use1pubrt" {
  vpc_id = aws_vpc.use1.id
  route  {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.use1igw.id
  }
  tags = {
    Name = "${var.orgnization}-${var.environment}-pubrt"
  }
}

resource "aws_route_table" "use1privrt" {
  vpc_id = aws_vpc.use1.id
  route  {
    cidr_block  = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.use1natgw.id
  }
  tags = {
    Name = "${var.orgnization}-${var.environment}-privrt"
  }
}

resource "aws_route_table_association" "use1pubsubnet1" {
  subnet_id = aws_subnet.use1subnet1.id
  route_table_id = aws_route_table.use1pubrt.id
}
resource "aws_route_table_association" "use1pubsubnet2" {
  subnet_id = aws_subnet.use1subnet2.id
  route_table_id = aws_route_table.use1pubrt.id
}

resource "aws_route_table_association" "use1privsubnet3" {
  subnet_id = aws_subnet.use1subnet3.id
  route_table_id = aws_route_table.use1privrt.id
}
resource "aws_route_table_association" "use1privsubnet4" {
  subnet_id = aws_subnet.use1subnet4.id
  route_table_id = aws_route_table.use1privrt.id
}
