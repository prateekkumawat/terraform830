resource "tls_private_key" "use1inskey" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
resource "aws_key_pair" "use1inskeypair" {
  key_name   = var.key_name
  public_key = tls_private_key.use1inskey.public_key_openssh
}
resource "local_file" "use1inskeyfile" {
  content  = tls_private_key.use1inskey.private_key_pem
  filename = "${var.key_name}.pem"
}
