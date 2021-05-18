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

# this instance are applied in s2 region
resource "aws_instance" "dev6" {
  provider = "aws.us-east-2-model"
  # you can find AMI in:
  # https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2#LaunchInstanceWizard:
  ami = "ami-077e31c4939f6a2f3"
  instance_type = "t2.micro"
  key_name = "terraform-aws-model"
  tags = {
    "Name" = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2-model.id}"]
  depends_on = ["aws_dynamodb_table.dynamodb-homologacao-model"]
}

# Utilizando referências entre os recursos
resource "aws_s3_bucket" "dev4" {
  bucket = "tf-model-dev4"
  acl    = "private"

  tags = {
    Name = "tf-model-dev4"
  }
}

resource "aws_dynamodb_table" "dynamodb-homologacao-model" {
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