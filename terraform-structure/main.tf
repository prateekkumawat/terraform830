resource "aws_vpc" "use1" {
 for_each = var.vpc_details
    cidr_block = each.value.cidr_block
    enable_dns_hostnames = each.value.enable_dns_hostnames
    enable_dns_support = each.value.enable_dns_support
    tags = {
        Name = "highsky-${var.orgnization_name}-${var.environment_name}-${each.value.prefix}-vpc"
    }
}

