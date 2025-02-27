# Variables in Terraform

Terraform confgirations can accept values through input variables.

variables help make configurations dynamic and reusable, so we don't have to hardcode values.

- Variables allow flexibility and customization.
- To reference a variable in terraform configuration file, we use `var.<variable_name>`.
- Store default values in `variables.tf` file, we can override default values by providing values for those variables in `terraform.tfvars` file.

### Step 1: Declare Variables (variables.tf)

Let's defines a variable with a default value as  t2.micro.

```cmd
variable "instance_type" {
  default = "t2.micro"
}
```

Now, we can use this variables in our main configuration file. 

### Step 2: Use Variables (main.tf)

In the example below, Instead of hardcoding "t2.micro" as instance_type, we use the varaiable as `var.instance_type`.

```cmd
resource "aws_instance" "my_vm" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
}
```

If we want to update the instance_type in future, we can do this by updating the variable value instead of changing the main configuration file.

### Step 3: Provide Values (terraform.tfvars)
We can override the default value by defining a different value in terraform.tfvars.
```cmd
instance_type = "t3.medium"
```
Now, when Terraform runs, it will use t3.medium instead of t2.micro.
