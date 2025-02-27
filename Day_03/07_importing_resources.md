# Importing Existing Resources

## Why Import Resources?

Let's say we have resources already deployed manually or via some other tools. Teraaform import helps us to easily map the existing resources to our terraform configuration, allowing us to manage these resources via terraform.

### Steps to Import Resources
**1. Add the resource to your configuration:**
```hcl
   resource "aws_instance" "web" {
     instance_type = "t2.micro"
   }
```
**2. Use terraform import to map the resource:**

When we run `terraform import` command, Terraform will fetch the current state of the resource from the provider (e.g., AWS) and update the Terraform state file (terraform.tfstate) with the resource's attributes.

Here is the syntax:

```hcl
terraform import <resource_type>.<resource_name> <resource_id>
```

Here is an example of importing existing aws instance

```hcl
terraform import aws_instance.web i-1234567890abcdef0
```

**3. Verify the import:**
After importing, update the configuration to match the imported resource's attributes:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456" # Update this to match the imported resource
  instance_type = "t2.micro"
}
```

Run `terraform plan` to ensure that the configuration matches the imported resource. 
If everything is correct, Terraform should show no changes.

