# Get default VPC and subnets
resource "aws_vpc" "teste_radiomemory_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = { Name = "teste-radiomemory-vpc" }
}

# Gateway to allow internet access in custom vpc
resource "aws_internet_gateway" "teste_radiomemory_igw" {
  vpc_id = aws_vpc.teste_radiomemory_vpc.id

  tags = {
    Name = "teste-radiomemory-igw"
  }
}

# Create route table
resource "aws_route_table" "teste_radiomemory_rt" {
  vpc_id = aws_vpc.teste_radiomemory_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.teste_radiomemory_igw.id
  }

  tags = {
    Name = "teste-radiomemory-rt"
  }
}

## Define subnets

resource "aws_subnet" "teste_radiomemory_subnet_a" {
  vpc_id            = aws_vpc.teste_radiomemory_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = { Name = "teste-radiomemory-subnet-a" }
}

# resource "aws_subnet" "teste_radiomemory_subnet_b" {
#   vpc_id            = aws_vpc.teste_radiomemory_vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "sa-east-1b"
#   map_public_ip_on_launch = true
#
#   tags = { Name = "teste-radiomemory-subnet-b" }
# }

resource "aws_subnet" "teste_radiomemory_subnet_c" {
  vpc_id            = aws_vpc.teste_radiomemory_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "sa-east-1c"
  map_public_ip_on_launch = true

  tags = { Name = "teste-radiomemory-subnet-c" }
}

## Create a subnet map to be used in other modules
locals {
  subnets_map = {
    "a" = aws_subnet.teste_radiomemory_subnet_a.id
    # "b" = aws_subnet.teste_radiomemory_subnet_b.id
    "c" = aws_subnet.teste_radiomemory_subnet_c.id
  }
}


## Associate subnets with routing table
resource "aws_route_table_association" "teste_radiomemory_subnet_a_assoc" {
  subnet_id      = aws_subnet.teste_radiomemory_subnet_a.id
  route_table_id = aws_route_table.teste_radiomemory_rt.id
}

# resource "aws_route_table_association" "teste_radiomemory_subnet_b_assoc" {
#   subnet_id      = aws_subnet.teste_radiomemory_subnet_b.id
#   route_table_id = aws_route_table.teste_radiomemory_rt.id
# }

resource "aws_route_table_association" "teste_radiomemory_subnet_c_assoc" {
  subnet_id      = aws_subnet.teste_radiomemory_subnet_c.id
  route_table_id = aws_route_table.teste_radiomemory_rt.id
}

