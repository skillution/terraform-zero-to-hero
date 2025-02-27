# Multiple configurations of same Provider - usage of Aliases

Let's say, we have a requirement to create multiple EC2 instances in different AWS regions. 

We can have more than one provider block (with same provider name) in our configuration file, and use alias to refer them differently in our resource blocks.

Terraform lets us manage multiple AWS regions within a single configuration file instead of creating separate configurations for each region. We can achieve this by defining multiple provider blocks, each specifying a different AWS region. 

To differentiate between these providers, we use the `alias` argument.

*Example configuration:*
---
In the example below, we are Creating EC2 Instances in Two Regions. We have to explicitly specify the additional provider name(aws.west) otherwise the default provider will be reffered.

```cmd
# Default AWS provider (us-east-1)
provider "aws" {
  region = "us-east-1"
}

# Additional AWS provider for the us-west-2 region
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

# EC2 instance in us-east-1 (default provider)
resource "aws_instance" "east_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

# EC2 instance in us-west-2 (explicitly using aws.west provider)
resource "aws_instance" "west_instance" {
  provider      = aws.west
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

`Note: The default provider is used for all resources unless explicitly specified.`
