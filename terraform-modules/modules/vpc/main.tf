# Specify the provider
provider "aws" {
  region = var.region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = var.tags
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = var.tags
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "my-public-subnet" })
}

# Create a Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = merge(var.tags, { Name = "my-private-subnet" })
}

# Create a Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  tags = merge(var.tags, { Name = "my-public-route-table" })
}

# Add a Route to the Internet Gateway in the Public Route Table
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnet with the Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a Private Route Table (Optional)
# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.my_vpc.id
#   tags = merge(var.tags, { Name = "my-private-route-table" })
# }

# # Associate Private Subnet with the Private Route Table
# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id      = aws_subnet.private_subnet.id
#   route_table_id = aws_route_table.private_route_table.id
# }