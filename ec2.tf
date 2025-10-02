resource "aws_instance" "teste_radiomemory_ec2" {
  count         = 2
  ami           = "ami-0816eee6501be9e04"  # Ubuntu 22.04 20250627
  instance_type = "t2.micro"
  associate_public_ip_address = true
  # for_each      = local.subnets_map
  # subnet_id     = each.value
  subnet_id     = element([
                    aws_subnet.teste_radiomemory_subnet_a.id,
                    aws_subnet.teste_radiomemory_subnet_c.id,
                  ], count.index)

  key_name      = aws_key_pair.teste_radiomemory_key.key_name
  vpc_security_group_ids = [aws_security_group.teste_radiomemory_sg.id]

  user_data = templatefile("${path.module}/scripts/setup-efs.sh", {
    EFS_ID = aws_efs_file_system.teste_radiomemory_efs.id
    REGION = data.aws_region.current.id
  })

  depends_on = [aws_efs_mount_target.teste_radiomemory_efs_targets]

  tags = {
    Name = "teste-radiomemory-EC2-with-EFS-${count.index + 1}"
  }
}

output "ec2_public_ips" {
  value = aws_instance.teste_radiomemory_ec2[*].public_ip
}
