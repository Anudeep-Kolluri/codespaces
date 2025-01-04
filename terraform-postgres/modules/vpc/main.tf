provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_a_cidr
  availability_zone       = var.subnet_a_az
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_b_cidr
  availability_zone       = var.subnet_b_az
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}


resource "aws_route" "default_route" {
  route_table_id         = aws_vpc.main.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}



# resource "aws_route_table" "main" {
#   vpc_id = aws_vpc.main.id
#   tags = {
#     Name = "main-route-table"
#   }
# }

# resource "aws_route_table_association" "main_association_a" {
#   subnet_id      = aws_subnet.subnet_a.id
#   route_table_id = aws_route_table.main.id
# }

# resource "aws_route_table_association" "main_association_b" {
#   subnet_id      = aws_subnet.subnet_b.id
#   route_table_id = aws_route_table.main.id
# }

resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  tags = {
    Name = "default-sg"
  }
}
