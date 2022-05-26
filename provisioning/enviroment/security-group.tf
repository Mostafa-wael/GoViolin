resource "aws_security_group" "sg" {
  name        = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id      = aws_vpc.app_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

    
    ingress { // Access http
        cidr_blocks = [
        "0.0.0.0/0"
        ]
        from_port = 80  
        to_port = 80    
        protocol = "tcp"
    }

    
    ingress { // Access jenkins
        cidr_blocks = [
        "0.0.0.0/0"
        ]
        from_port = 8080  
        to_port = 8080   
        protocol = "tcp"
    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}
