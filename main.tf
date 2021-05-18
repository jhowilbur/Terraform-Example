provider "aws" {
  # version = "~> 2.0" deprecated
  region = "us-east-1"
  # parameter for using specific .aws/credentials
  profile = "terraform_from_ni_notebook"
}

resource "aws_instance" "dev" {
    count = 3
  ami = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"
  key_name = "terraform-aws-notebook-ni"
  tags = {
    "Name" = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

resource "aws_instance" "dev4" {
  ami = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"
  key_name = "terraform-aws-notebook-ni"
  tags = {
    "Name" = "dev4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
  depends_on = ["aws_s3_bucket.dev4"]
}

resource "aws_instance" "dev5" {
  ami = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"
  key_name = "terraform-aws-notebook-ni"
  tags = {
    "Name" = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# aplicar esse security group primeiro para conseguir prosseguir
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"
  # vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["what_is_my_ip"]
  }

  tags = {
    Name = "ssh-tf-model"
  }
}

# Utilizando referências entre os recursos
resource "aws_s3_bucket" "dev4" {
  bucket = "tf-model-dev4"
  acl    = "private"

  tags = {
    Name = "tf-model-dev4"
  }
}