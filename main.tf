provider "aws" {
  # provider = "aws.us-east-2-model"
  # version = "~> 2.0" - deprecated
  region = "us-east-1"
  # parameter for using specific .aws/credentials
  profile = "terraform_from_ni_notebook"
}

provider "aws" {
  alias = "us-east-2-model"
  region = "us-east-2"
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
  ami = var.amis["us-east-1"]
  instance_type = var.instance_type
  key_name = var.key_name["us-east-1"]
  tags = {
    "Name" = "dev4"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
  depends_on = ["aws_s3_bucket.dev4"]
}

resource "aws_instance" "dev5" {
  ami = var.amis["us-east-1"]
  instance_type = var.instance_type
  key_name = var.key_name["us-east-1"]
  tags = {
    "Name" = "dev5"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"]
}

# this instance are applied in s2 region
resource "aws_instance" "dev6" {
  provider = "aws.us-east-2-model"
  ami = var.amis["us-east-2"]
  instance_type = var.instance_type
  key_name = var.key_name["us-east-2"]
  tags = {
    "Name" = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2-model.id}"]
  depends_on = ["aws_dynamodb_table.dynamodb_homologacao_model"]
}

# Utilizando referências entre os recursos
resource "aws_s3_bucket" "dev4" {
  bucket = "tf-model-dev4"
  acl    = "private"

  tags = {
    Name = "tf-model-dev4"
  }
}

resource "aws_dynamodb_table" "dynamodb_homologacao_model" {
  provider = "aws.us-east-2-model"
  name           = "DynamodbModel"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "TitleDynamodbModel"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "TitleDynamodbModel"
    type = "S"
  }
}