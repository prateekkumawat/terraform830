module "stage-infra" {
  source        = "terraform-aws-modules/vpc/aws"
  name          =  "stage-vpc"
  cidr          = "10.20.0.0/16"
  azs           = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

  public_subnets   =  ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  private_subnets  =  ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]
  database_subnets =  ["10.20.201.0/24", "10.20.202.0/24", "10.20.203.0/24"]

  create_igw =  true

}

#################################
# s3 bucket modules
##################################

module "stage-s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "hsit-stage-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
module "pp-s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "hsit-pp-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}
