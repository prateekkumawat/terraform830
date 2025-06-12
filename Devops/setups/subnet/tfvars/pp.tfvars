aws_region = "ap-south-1"
subnet_details = {
  highsky-use1-pp = {
    prefix       = "pp-subnet"
    cidr_block = "10.10.1.0/24"
    avaibility_zone = "ap-south-1a"
    vpc_id = "vpc-0e6dafec5d0476907"
    map_public_ip_on_launch = true
    tags = {
      Name = "pp-subnet"
      enviornment = "pp"
      info = "pp"
      createbyterraform = "true"
    }
  }
} 