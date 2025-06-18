resource "aws_security_group" "use1inssg" {
  vpc_id = var.aws_vpc_id
  name = "${var.orgnization}-${var.environment}-instance-sg"
  description = "Instaance security group for ${var.orgnization} in ${var.environment}"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  lifecycle {
    ignore_changes = all
  } 
}
