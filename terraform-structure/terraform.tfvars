orgnization_name = "training"
environment_name = "cano"
region = "ap-south-1"
vpc_details = {
  stage = {
    cidr_block = "10.10.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    prefix = "stage"
  }

  pp = {
    cidr_block = "10.20.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    prefix = "pp"
  }

   prod = {
    cidr_block = "10.30.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    prefix = "prod"
  }
}