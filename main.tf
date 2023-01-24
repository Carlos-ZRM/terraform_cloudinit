resource "aws_security_group" "allow_cockpit" {
  name        = "allow_cockpit"
  description = "Allow cockpit inbound traffic"
  vpc_id      = "vpc-984342ff"

  ingress {
    description      = "Cockpit from VPC"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_cockpit"
  }
}

data "template_file" "user_data" {
  template = file("user-data")
}

resource "aws_instance" "web" {
  count = 4
  ami                         = "ami-0a1a70369f0fce06a"
  instance_type               = "t3a.micro"
  subnet_id                   = "subnet-61bd4d07"
  vpc_security_group_ids      = [aws_security_group.allow_cockpit.id]
  associate_public_ip_address = true
  key_name = "terrafor_ED25519"
  user_data                   = data.template_file.user_data.rendered

  tags = {
    Name = "CloudInit"
  }
}