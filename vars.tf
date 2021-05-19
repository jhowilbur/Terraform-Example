variable "amis" {
#   type = "map" -> deprecated
  default = {
    # you can find AMI in:
    # https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2#LaunchInstanceWizard:
    "us-east-1" = "ami-0747bdcabd34c712a"
    "us-east-2" = "ami-077e31c4939f6a2f3"
  }
}

variable "cdirs_acesso_remoto" {
#   type = "list" -> deprecated
  default = ["what_is_my_ip/32"]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = {
      "us-east-1" = "terraform-aws-notebook-ni"
      "us-east-2" = "terraform-aws-model"
  }
}
