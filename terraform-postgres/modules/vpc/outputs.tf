output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_a_id" {
  description = "The ID of subnet A"
  value       = aws_subnet.subnet_a.id
}

output "subnet_b_id" {
  description = "The ID of subnet B"
  value       = aws_subnet.subnet_b.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}

output "security_group_id" {
  description = "The ID of the default security group"
  value       = aws_security_group.default.id
}
