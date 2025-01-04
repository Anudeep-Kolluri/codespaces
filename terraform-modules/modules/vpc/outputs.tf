# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

# Output the CIDR block of the VPC
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.my_vpc.cidr_block
}

# Output the Public Subnet ID
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

# Output the CIDR block of the Public Subnet
output "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  value       = aws_subnet.public_subnet.cidr_block
}

# Output the Private Subnet ID
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

# Output the CIDR block of the Private Subnet
output "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  value       = aws_subnet.private_subnet.cidr_block
}

# Output the Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output the Public Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route_table.id
}

# Output the Private Route Table ID
# output "private_route_table_id" {
#   description = "The ID of the private route table"
#   value       = aws_route_table.private_route_table.id
# }
