resource "aws_instance" "teste_radiomemory_ec2" {
  count         = 2
  ami           = "ami-0816eee6501be9e04"  # Ubuntu 22.04 20250627
  instance_type = "t2.micro"
  subnet_id     = element(data.aws_subnets.default.ids, count.index)
  vpc_security_group_ids = [aws_security_group.efs_ec2_sg.id]
  key_name      = "teste-radiomemory-key"

  user_data = templatefile("${path.module}/scripts/setup-efs.sh", {
    EFS_ID = aws_efs_file_system.my_efs.id
  })

  tags = {
    Name = "teste-radiomemory-EC2-with-EFS-${count.index + 1}"
  }
}
