# Get up and running with AWs Elastic Beanstalk
## Prerequisites
1. An AWS account in which you have full EB permissions (or higher)
2. AWS CLI (if you aren't using the AWS web console)

### Set up EB user (skip if you already have an IAM User with the following Roles and Policy)
#### Create an IAM Group with the following Roles:
1. ElasticLoadBalancingFullAccess
2. AWSElasticBeanstalkFullAccess
3. Add an inline Policy for the service linked role:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:CreateServiceLinkedRole",
      "Resource": "arn:aws:iam::*:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing*",
      "Condition": {
        "StringLike": {
          "iam:AWSServiceName": "elasticloadbalancing.amazonaws.com"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:AttachRolePolicy",
        "iam:PutRolePolicy"
      ],
      "Resource": "arn:aws:iam::*:role/aws-service-role/elasticloadbalancing.amazonaws.com/AWSServiceRoleForElasticLoadBalancing*"
    }
  ]
}
```
#### Create a user and add them to the group above

### Use the AWS CLI to create and activate the Environment
```bash
$ cd ibmsite
# Initialize the folder, creating .elasticbeanstalk/ folder for configs
$ eb init --platform "64bit Amazon Linux 2018.03 v2.8.4 running Ruby 2.5 (Puma)" --region $AWS_REGION ibmsite-dev
# Use the example config file
$ mv fb6ba8e.cfg.yml.example ibmsite.cfg.yml
$ eb config ibmsite-dev --cfg ibmsite.cfg.yml
# Deploy the code to your environment
$ eb deploy
```

## Reference: AWS eb CLI instructions
> Install using latest instructions at https://docs.aws.amazon.com/cli/latest/userguide/installing.html

> Handy cheatsheet for the `eb` commands specifically: https://github.com/jacquesfu/aws-eb-cli-cheatsheet
