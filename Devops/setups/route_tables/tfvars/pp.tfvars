aws_region = "ap-south-1"
routetable_details = {
    highsky-use1-public = { 
        vpc_id    = "vpc-08f6d17ce5593b465"
        tags      = {
            Name    = highsky-use1-public-rt 
            enviornment = "pp"
            info = "pp"
            createbyterraform = "true"
        }
    }
    highsky-use1-private = { 
        vpc_id    = "vpc-08f6d17ce5593b465"
        tags      = {
            Name    = highsky-use1-private-rt 
            enviornment = "pp"
            info = "pp"
            createbyterraform = "true"
        }
    }
}