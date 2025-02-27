# Workspaces

## What are Workspaces?
Workspaces allows us to manage multiple environments (e.g., dev, staging, prod) within the same configuration.

## Creating and Switching Workspaces
1. List workspaces:

```hcl
   terraform workspace list
```

2. Create a new workspace:
```hcl
terraform workspace new dev
```

3. Switch workspaces:
```hcl
terraform workspace select dev
```

## Using Workspaces in Configurations
Use the terraform.workspace variable to customize configurations:

```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = terraform.workspace == "prod" ? "t2.large" : "t2.micro"
}
```
