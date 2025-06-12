module "subnet" {
  source = "../../modules/subnet_zone"
  subnet_details = var.subnet_details
}
