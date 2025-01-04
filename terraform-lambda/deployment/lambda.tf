provider "aws" {
  region = "us-east-1"  # Choose your region
}

resource "aws_vpc" "my_vpc"{
  cidr_block = "10.0.0.0/28"
  tags = {
    Name = "terraform"
  }
}