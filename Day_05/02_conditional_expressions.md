# Conditional Expressions

## Conditional Logic with count

In Terraform, conditional expressions allow you to control the creation of resources, or the values of resource arguments, based on input variables or other conditions. 

This makes your infrastructure configurations more flexible and dynamic.

Lets look at a sample conditional logic with `count`. In this example, create_instance is a boolean variable and the aws instance will be created if the create_instance is true.

```hcl

# var.create_instance is a boolean variable.

variable "create_instance" {
  type    = bool
  default = true
}

resource "aws_instance" "example" {

  # The ternary operator ? : checks the value of var.create_instance.
  # If true, count = 1 (one instance is created).
  # If false, count = 0 (no instance is created).

  count = var.create_instance ? 1 : 0

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

```

## Conditional Logic with for_each

While count is great for simple scenarios, for_each is ideal when you need to create multiple unique instances of a resource, each potentially having different configurations.

In the below example, terraform create one aws_instance for each map key(prod, dev, stage) with each map value as instance type.

```hcl

variable "instances_map" {
  type = map(string)
  default = {
    "prod"  = "t3.medium"
    "dev"   = "t2.micro"
    "stage" = "t2.small"
  }
}

resource "aws_instance" "multi_example" {
  for_each = var.instances_map

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value
  tags = {
    Name = each.key
  }
}

```

Each instance has a unique name tag (Name = each.key) and instance type (instance_type = each.value).
