# example of how to automatically provision cloud environments

In this example we will use AWS

------------------------

## First Steps

- own aws-cli
- install terraform on bash
- have user configured in aws-cli
- assemble a ssh-keygen 

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
terraform sow
```

- for verify ec2 security groups
```
aws configure list-profiles
aws ec2 describe-security-groups --profile {}
```