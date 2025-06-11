#################################################
#   VPC Only with subnet and internet gateway
#    used for only RDS Deployment   
##################################################
resource "aws_vpc" "use1" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.orgnization_name}-${var.environment_name}-vpc"
  }
}

resource "aws_subnet" "use1subnet1" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr_blocks[0]
  availability_zone = var.azs[0]
  tags = {
    Name = "${var.orgnization_name}-${var.environment_name}-subnet1-az1"
  }
}

resource "aws_subnet" "use1subnet2" {
  vpc_id = aws_vpc.use1.id
  cidr_block = var.subnet_cidr_blocks[1]
  availability_zone = var.azs[1]
  tags = {
    Name = "${var.orgnization_name}-${var.environment_name}-subnet2-az2"
  }
}

resource "aws_internet_gateway" "use1igw" {
  vpc_id = aws_vpc.use1.id
  tags = {
    Name = "${var.orgnization_name}-${var.environment_name}-igw"
  }
}


####################################################
#   RDS Instance with Multi-AZ Deployment
#    used for only RDS Deployment
####################################################

resource "aws_db_subnet_group" "use1dbsg" {
  name       = "${var.orgnization_name}-${var.environment_name}-db-subnet-group"
  subnet_ids = [aws_subnet.use1subnet1.id, aws_subnet.use1subnet2.id]

  tags = {
    Name = "${var.orgnization_name}-${var.environment_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "use1rds" {
  identifier          = "${var.orgnization_name}-${var.environment_name}-mysql-db"
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "prateek"
  password             = "Prateek123456"
  db_subnet_group_name = aws_db_subnet_group.use1dbsg.name
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = false
  vpc_security_group_ids = [aws_security_group.use1rds_sg.id]
}


################################################
#   Security Group for RDS Instance
#    used for only RDS Deployment   
################################################

resource "aws_security_group" "use1rds_sg" {
  name        = "${var.orgnization_name}-${var.environment_name}-rds-sg"
  description = "Security group for RDS instance built with Terraform"
  vpc_id      = aws_vpc.use1.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.orgnization_name}-${var.environment_name}-rds-sg"
  }
}