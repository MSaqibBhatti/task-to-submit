# VPC with the name task-vpc 
resource "aws_vpc" "task-vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "task-vpc"
  }
}

# This is the Public Subnet for Availability Zone 1
resource "aws_subnet" "PubSub-1" {
  vpc_id                  = aws_vpc.task-vpc.id
  cidr_block              = var.PubSub_1
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_1
  tags = {
    Name = "public_subnet_1"
  }
}

# This is the Public Subnet for Availability Zone 2
resource "aws_subnet" "PubSub-2" {
  vpc_id                  = aws_vpc.task-vpc.id
  cidr_block              = var.PubSub_1
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_2
  tags = {
    Name = "public_subnet_2"
  }
}



# This is the Private Subnet for Availability Zone 1
resource "aws_subnet" "PrivSub-1" {
  vpc_id                  = aws_vpc.task-vpc.id
  cidr_block              = var.PrivSub_1
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_1
  tags = {
    Name = "private_subnet_1"
  }
}

# This is the Private Subnet for Availability Zone 2
resource "aws_subnet" "PrivSub-2" {
  vpc_id                  = aws_vpc.task-vpc.id
  cidr_block              = var.PrivSub_2
  map_public_ip_on_launch = "true"
  availability_zone       = var.az_2
  tags = {
    Name = "private_subnet_2"
  }
}



# Internet Gateway for Public Access
resource "aws_internet_gateway" "task-IGW" {
  vpc_id = aws_vpc.task-vpc.id
  tags = {
    Name = "task-IGW"
  }
}

# Main Route Table 
resource "aws_route_table" "Pub-RT" {
  vpc_id = aws_vpc.task-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.task-IGW.id
  }

  tags = {
    Name = "Public_RT"
  }
}

# Route table association with Public Subnets of Availability Zones 1a and 1b 
resource "aws_route_table_association" "Pub-1-a" {
  subnet_id      = aws_subnet.PubSub-1.id
  route_table_id = aws_route_table.Pub-RT.id
}

resource "aws_route_table_association" "Pub-2-a" {
  subnet_id      = aws_subnet.PubSub-2.id
  route_table_id = aws_route_table.Pub-RT.id
}
