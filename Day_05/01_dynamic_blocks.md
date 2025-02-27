## Dynamic Blocks in Terraform

Dynamic blocks in Terraform let you programmatically generate nested blocks within a resource or module. 

They are particularly useful when you need to create multiple similar blocks without having to write repetitive code.

**Example:**

Consider a scenario where you want to create several ingress rules for an AWS Security Group. 

Instead of defining each ingress block individually, you can use a dynamic block to loop through a variable containing multiple ingress rule definitions.

```hcl
resource "aws_security_group" "sgroup" {
  name_prefix = "sgroup-"

  # 'dynamic' introduces a new block type named "ingress"
  dynamic "ingress" {
    
    # 'for_each' iterates over the variable that holds ingress rules
    for_each = var.ingress_rules
    
    # The 'content' block defines the structure each generated block should have
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
```

Below is the example for variable and its values in .tfvars

```hcl
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# Example input in a .tfvars file:
ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]
```

With this setup, Terraform automatically creates separate ingress blocks for each object in the ingress_rules list.
