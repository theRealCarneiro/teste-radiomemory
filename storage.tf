resource "aws_efs_file_system" "teste_radiomemory_efs" {
  creation_token = "teste-radiomemory-efs"
}

resource "aws_efs_mount_target" "efs_targets" {
  for_each        = toset(data.aws_subnets.default.ids)
  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs_ec2_sg.id]
}
