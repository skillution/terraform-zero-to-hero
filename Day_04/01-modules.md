# Modules

## What are Modules?

In simple terms, module is a directory or package with its own set of Terraform configuration files. Modules allow us to encapsulate and reuse infrastructure code.

## Creating a Module
1. Create a directory for your module (e.g., `modules/vpc`).
2. Add Terraform configuration files (e.g., `main.tf`, `variables.tf`, `outputs.tf`).
3. Define inputs using `variables.tf` and outputs using `outputs.tf`.

### Example: VPC Module
```hcl
# modules/vpc/main.tf
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

# modules/vpc/variables.tf
variable "cidr_block" {
  type = string
}

# modules/vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}
```

## Using a Module
To use the VPC Module, call the module in our root configuration as below:

```hcl
# main.tf
module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}
```

Use modules to organize and reuse code.

We can also publish modules to the Terraform Registry and share with others.
