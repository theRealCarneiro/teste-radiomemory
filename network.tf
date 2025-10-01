# Get default VPC and subnets
resource "aws_vpc" "teste_radiomemory_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = { Name = "teste-radiomemory-vpc" }
}

resource "aws_subnet" "teste_radiomemory_subnet_a" {
  vpc_id            = aws_vpc.teste_radiomemory_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"

  tags = { Name = "teste-radiomemory-subnet-a" }
}

resource "aws_subnet" "teste_radiomemory_subnet_b" {
  vpc_id            = aws_vpc.teste_radiomemory_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "sa-east-1b"

  tags = { Name = "teste-radiomemory-subnet-b" }
}

# resource "aws_subnet" "teste_radiomemory_subnet_c" {
#   vpc_id            = aws_vpc.teste_radiomemory_vpc.id
#   cidr_block        = "10.0.3.0/24"
#   availability_zone = "sa-east-1c"
#
#   tags = { Name = "teste-radiomemory-subnet-c" }
# }

locals {
  subnets_map = {
    "a" = aws_subnet.teste_radiomemory_subnet_a.id
    "b" = aws_subnet.teste_radiomemory_subnet_b.id
    # "c" = aws_subnet.teste_radiomemory_subnet_c.id
  }
}
