provider "aws" {
    region = "us-east-1"
}

# create AWS VPC
resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "Main VPC"
    }
}

# Create a AWS Subnet
resource "aws_subnet" "main_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public Subnet"
    }
}

# Create a private Subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "Private Subnet"
    }
}

# Create AWS Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "IGW"
    }
}

# Create public route table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
        Name = "public route table"
    }
}

# creating the route
resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

# route table association
resource "aws_route_table_association" "association" {
    subnet_id = aws_subnet.main_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}