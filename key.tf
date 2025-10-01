# Define key parameters
resource "tls_private_key" "teste_radiomemory_key" {
  algorithm       = "RSA"
  rsa_bits        = 4096
}

# Register on aws
resource "aws_key_pair" "teste_radiomemory_key" {
  key_name        = "teste-radiomemory-key"
  public_key      = tls_private_key.teste_radiomemory_key.public_key_openssh
}

# Save priv key file locally
resource "local_file" "teste_radiomemory_key_pem" {
  content         = tls_private_key.teste_radiomemory_key.private_key_pem
  filename        = "${path.module}/teste-radiomemory-key.pem"
  file_permission = "0400"
}
