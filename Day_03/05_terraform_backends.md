# Terraform Backends

## What is a Backend?
A backend defines where Terraform stores its state file. It can be local or remote.

## Types of Backends
- **Local:** Default backend (local file).
- **Remote:** Stores state in a remote service (e.g., S3, Azure Storage, Terraform Cloud).

## Configuring a Remote Backend
### Example: AWS S3 Backend
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "path/to/my/state.tfstate"
    region = "us-east-1"
  }
}
```
