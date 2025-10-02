# Create EFS
resource "aws_efs_file_system" "teste_radiomemory_efs" {
  creation_token = "teste-radiomemory-efs"
  tags = { Name = "teste-radiomemory-efs" }
}

# Make EFS available in subnets
resource "aws_efs_mount_target" "teste_radiomemory_efs_targets" {
  for_each      = local.subnets_map

  file_system_id  = aws_efs_file_system.teste_radiomemory_efs.id
  subnet_id       = each.value
  security_groups = [aws_security_group.teste_radiomemory_efs_sg.id]
}
