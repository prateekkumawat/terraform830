resource "aws_instance" "use1ins1" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  subnet_id     = var.instance_subnet_id
  key_name      = var.aws_instance_keypair
  vpc_security_group_ids  = [var.aws_securitygroup_id]
  
  tags = {
    Name = "${var.orgnization}-${var.environment}-instance-1"
  }
  lifecycle {
    ignore_changes = all
  }
}
