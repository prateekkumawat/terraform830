orgnization_name = "training"
environment_name = "stage"
region = "ap-south-1"
vpc_details = {
  use1 = {
    cidr_block = "10.10.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    prefix = "use1"
  }

  use2 = {
    cidr_block = "10.20.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    prefix = "use2"
  }

   use3 = {
    cidr_block = "10.30.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    prefix = "use3"
  }
}