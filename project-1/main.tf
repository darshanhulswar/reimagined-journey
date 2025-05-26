provider "aws" {
    region = "us-east-1"
}

# creating my vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "VPC-project"
    }
}

#create a subnet-1
resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "subnet-1"
    }
}

#create a subnet-2
resource "aws_subnet" "subnet_2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true
    tags = {
        Name = "subnet-2"
    }
}

# creating internet gw
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = "MyIGW"
    }
}

#creating the route table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      name = "route_table-custom"
    }
}

# creating the route
resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id

}

#route associations
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.public_route_table.id

}


