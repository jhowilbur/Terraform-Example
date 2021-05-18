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
  # vpc_security_group_ids = ["${aws_security_group.launch-wizard-1.id}"]
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
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  # egress {
  #   from_port        = 0
  #   to_port          = 0
  #   protocol         = "-1"
  #   cidr_blocks      = ["0.0.0.0/0"]
  #   ipv6_cidr_blocks = ["::/0"]
  # }

  tags = {
    Name = "ssh-tf-alura"
  }
}

# Utilizando referências entre os recursos
# resource "aws_s3_bucket" "dev4" {
#   ami = "ami-0747bdcabd34c712a"
#   instance_type = "t2.micro"
#   key_name = "terraform-aws-notebook-ni"
#   tags = {
#     Name        = "tf-bucket-dev4"
#     Environment = "Dev4"
#   }
#   vpc_security_group_ids = ["${aws_security_group.launch-wizard-1.id}"]
# }

# resource "aws_s3_bucket" "dev5" {
#   ami = "ami-0747bdcabd34c712a"
#   instance_type = "t2.micro"
#   key_name = "terraform-aws-notebook-ni"
#   tags = {
#     Name        = "tf-bucket-dev4"
#     Environment = "Dev4"
#   }
#   vpc_security_group_ids = ["${aws_security_group.launch-wizard-1.id}"]
# }