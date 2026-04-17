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

# EC2 Instance
# resource "aws_instance" "ec2" {
#   ami           = "ami-0f58b397bc5c1f2e8"
#   instance_type = "t3.micro"

#   subnet_id = aws_subnet.sub.id

#   key_name               = "sayan-key-2tier-app"
#   vpc_security_group_ids = [aws_security_group.sg.id]

#   tags = {
#     Name = "terra-ec2"
#   }
# }

# =========================
# EC2 Instance
# =========================
resource "aws_instance" "ec2" {
  ami           = "ami-0f58b397bc5c1f2e8" # Ubuntu AMI
  instance_type = "t3.micro" # free tier

  subnet_id = aws_subnet.sub.id

  key_name               = "sayan-key-2tier-app" # your key
  vpc_security_group_ids = [aws_security_group.sg.id]

  associate_public_ip_address = true  # ✅ ADD THIS


  # =========================
  # USER DATA (AUTO SETUP)
  # =========================
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Hello Sayan 🚀</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "terra-ec2"
  }
}

# =========================
# Output Public IP
# =========================
output "public_ip" {
  value = aws_instance.ec2.public_ip
}