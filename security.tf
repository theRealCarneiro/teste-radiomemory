# Security group for SSH
resource "aws_security_group" "teste_radiomemory_ec2_sg" {
  name        = "teste-radiomemory-ec2-sg"
  description = "Allow SSH in EC2"
  vpc_id      = aws_vpc.teste_radiomemory_vpc.id

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # In prod it would be better to limit the IPs that can access
	}

	# Allow outgoing traffic
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

# Security group for EFS
resource "aws_security_group" "teste_radiomemory_efs_sg" {
  name        = "teste-radiomemory-efs-sg"
  description = "Allow NFS"
  vpc_id      = aws_vpc.teste_radiomemory_vpc.id

  # NFS
	ingress {
		from_port   = 2049
		to_port     = 2049
		protocol    = "tcp"
    security_groups = [aws_security_group.teste_radiomemory_ec2_sg.id]
	}
}
