# aplicar esse security group primeiro para conseguir prosseguir
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["what_is_my_ip/32"]
  }

  tags = {
    Name = "ssh-tf-model"
  }
}

# for east-2
resource "aws_security_group" "acesso-ssh-us-east-2-model" {
  # insert hier alias from aws
  provider = "aws.us-east-2-model"
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_acesso_remoto
  }

  tags = {
    Name = "ssh-tf-model"
  }
}