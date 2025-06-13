module "vpc" {
  source = "../../modules/vpc_zone"

  vpc_details = var.vpc_details
}
