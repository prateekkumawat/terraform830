resource "aws_route_table" "main" {
  for_each =  local.routetable_blocks
  vpc_id   = each.value.vpc_id
  tags     = each.value.tags
}