# Creating VPC using terraform

resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terra-vpc"
  }
}

# Creating subnet 

resource "aws_subnet" "sub" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true # auto assign public IP

  tags = {
    Name = "terra-sub"
  }
}

# Creating internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terra-igw"
  }
}

# Creating route table

resource "aws_route_table" "table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terra-table"
  }
}

# Add subnet to route table

resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.sub.id
  route_table_id = aws_route_table.table.id
}


# Open route to internet gateway

resource "aws_route" "r" {
  route_table_id            = aws_route_table.table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# # Security Group (SSH)
# resource "aws_security_group" "sg" {
#   name   = "terra-sg"
#   vpc_id = aws_vpc.vpc.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # for testing
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# =========================
# Security Group (Firewall)
# =========================
resource "aws_security_group" "sg" {
  name   = "terra-sg"
  vpc_id = aws_vpc.vpc.id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # open for all (only testing)
  }

  # HTTP access (for website)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

