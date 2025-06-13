############################################
#    terraform vpc create example
############################################
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


#######################################################
#   terraform security group  create example
#######################################################
resource "aws_security_group" "use1inssg" {
  vpc_id = aws_vpc.use1.id
  name = "${var.orgnization}-${var.environment}-instance-sg"
  description = "Instaance security group for ${var.orgnization} in ${var.environment}"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  lifecycle {
    ignore_changes = all
  } 
}

resource "aws_security_group" "use1elbsg" {
  vpc_id = aws_vpc.use1.id
  name = "${var.orgnization}-${var.environment}-elb-sg"
  description = "ELB security group for ${var.orgnization} in ${var.environment}"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  lifecycle {
    ignore_changes = all
  }
}



#######################################################
#   terraform keypair create example    
####################################################### 
resource "tls_private_key" "use1inskey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "use1inskeypair" {
  key_name   = "use1-inskey"
  public_key = tls_private_key.use1inskey.public_key_openssh
}
resource "local_file" "use1inskeyfile" {
  content  = tls_private_key.use1inskey.private_key_pem
  filename = "use1-inskey.pem"
}

#######################################################
#   terraform instance create example   
#######################################################
resource "aws_instance" "use1ins1" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  subnet_id     = aws_subnet.use1subnet3.id
  key_name      = aws_key_pair.use1inskeypair.key_name
  vpc_security_group_ids  = [aws_security_group.use1inssg.id]
  
  tags = {
    Name = "${var.orgnization}-${var.environment}-instance-1"
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_instance" "use1ins2" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  subnet_id     = aws_subnet.use1subnet4.id
  key_name      = aws_key_pair.use1inskeypair.key_name
  vpc_security_group_ids  = [aws_security_group.use1inssg.id]
  
  tags = {
    Name = "${var.orgnization}-${var.environment}-instance-2"
  }
    lifecycle {
        ignore_changes = all
    }
}

########################################################
#   terraform elb create example    
########################################################
resource "aws_elb" "use1elb" {
  name               = "${var.orgnization}-${var.environment}-elb"
  #availability_zones = ["ap-south-1a", "ap-south-1b"]
  security_groups    = [aws_security_group.use1elbsg.id]
  subnets            = [aws_subnet.use1subnet1.id, aws_subnet.use1subnet2.id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  instances = [aws_instance.use1ins1.id, aws_instance.use1ins2.id]

  tags = {
    Name = "${var.orgnization}-${var.environment}-elb"
  }
}

resource "aws_elb_attachment" "use1elbins1" {
  elb      = aws_elb.use1elb.id
  instance = aws_instance.use1ins1.id
}

resource "aws_elb_attachment" "use1elbins2" {
  elb      = aws_elb.use1elb.id
  instance = aws_instance.use1ins2.id
}