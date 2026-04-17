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