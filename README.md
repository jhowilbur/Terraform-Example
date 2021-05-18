# example of how to automatically provision cloud environments

In this example we will use AWS

------------------------

## First Steps

- own aws-cli
- install terraform on bash
- have user configured in aws-cli


### assemble a ssh-keygen 

- making a key in the same path from project
```
 ssh-keygen -f terraform-aws -t rsa
```
copy .pem and .pub to ssh path -> ~/.ssh

- are necessary to import this *.pub generated key pair on AWS, for example:
```
https://us-east-2.console.aws.amazon.com/ec2/v2/home?region=us-east-2#ImportKeyPair:
```

- and finally if you need you can connect to ec2 instance for example:
```
ssh -i "~/.ssh/terraform-aws" see_in_aws@see_in_aws.amazonaws.com

```

------------------------

## Commands to run

- inside main.tf folder using those command:
```
terraform init
terraform plan
terraform apply
```

## Others commands

- for verify how are structure in AWS about your project
```
terraform show
```

- for verify ec2 security groups
```
aws configure list-profiles
aws ec2 describe-security-groups --profile name_in_path_aws_credentials
```