resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "test_sub1" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "test-subnet-1"
  }
}

resource "aws_subnet" "test_sub2" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "test-subnet-2"
  }
}

resource "aws_subnet" "test_sub3" {
  vpc_id            = aws_vpc.test.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "us-east-1c"
  tags = {
    Name = "test-subnet-3"
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "test-igw"
  }
}

resource "aws_route_table" "test_rt" {
  vpc_id = aws_vpc.test.id  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }
}

resource "aws_route_table_association" "test_sub1" {
  subnet_id = aws_subnet.test_sub1.id
  route_table_id = aws_route_table.test_rt.id
}