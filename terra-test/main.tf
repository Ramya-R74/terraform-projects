resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "terra-connect" {
  name        = "terra-aws-sg"
  description = "Allow user to connect via SG"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = " allow all outgoing traffic "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terra-aws-sg"
  }
}

resource "aws_instance" "my_instance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.terra-key.key_name

  connection {
    type        = "ssh"
    user        = "ec2-user"  # Replace with the appropriate username for your EC2 instance
    private_key = file("/workspaces/terraform-projects/terra-test/.ssh/terra-key")  # Replace with the path to your private key
    host        = self.public_ip
  }

  tags = {
    Name = "Terraform-aws-project"
  }
}