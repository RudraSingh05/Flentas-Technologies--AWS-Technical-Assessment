terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# ---------------------
# Key Pair
# ---------------------
resource "aws_key_pair" "Rudra_Singh_key" {
  key_name   = "Rudra_Singh_Key"
  public_key = file("${path.module}/ec2key.pub")
}

# ---------------------
# Security Group
# ---------------------
resource "aws_security_group" "Rudra_Singh_sg" {
  name        = "Rudra_Singh_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-0b0bd10163043375d"  # <-- Replace with your VPC ID

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------------
# EC2 Instance
# ---------------------
resource "aws_instance" "Rudra_Singh_ec2" {
  ami                         = "ami-0d176f79571d18a8f"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-05c56009aa1dd7894"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.Rudra_Singh_key.key_name
  vpc_security_group_ids      = [aws_security_group.Rudra_Singh_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "Rudra_Singh_EC2"
  }

  # Upload resume PDF
  provisioner "file" {
    source      = "${path.module}/rudra_singh.pdf"
    destination = "/home/ec2-user/rudra_singh.pdf"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("${path.module}/Rudra_Singh_.pem")
    }
  }

  # Restart nginx after PDF upload
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl restart nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("${path.module}/Rudra_Singh_.pem")
    }
  }
}

# ---------------------
# Output
# ---------------------
output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.Rudra_Singh_ec2.public_ip
}
