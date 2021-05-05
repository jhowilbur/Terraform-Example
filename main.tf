provider "aws" {
#   version = "~> 2.0" deprecated
  region = "us-east-1"
}

resource "aws_instance" "dev" {
    count = 3
  ami = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  tags = {
    "Name" = "dev${count.index}"
  }
}

