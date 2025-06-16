aws_region = "ap-south-1"
vpc_details = {
 highsky-use1-pp = {   
   Name       = "pp-vpc"
   cidr_block = "10.10.0.0/16"
   prefix     = "highsky-use1"
   tags = {
    enviornment = "pp"
    info = "pp"
    createbyterraform = "true"
   }
  }   
} 