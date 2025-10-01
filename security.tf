# Security group for SSH + NFS
resource "aws_security_group" "teste_radiomemory_sg" {
  name        = "teste-radiomemory-sg"
  description = "Allow SSH and NFS"
  vpc_id      = aws_vpc.teste_radiomemory_vpc.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # In prod it would be better to limit the IPs that can access
	}

	# NFS
	ingress {
		from_port   = 2049
		to_port     = 2049
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	# Allow outgoing traffic
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
