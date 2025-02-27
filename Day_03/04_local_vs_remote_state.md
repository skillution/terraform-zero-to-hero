# Local vs Remote State

## Local State
- **Default behavior:** Terraform state is stored locally in a `terraform.tfstate` file.
- **Pros:**
  - Simple to use.
  - No additional setup required.
- **Cons:**
  - Not suitable for team collaboration.
  - Risk of losing the state file.

## Remote State
- **Default behavior:** State is stored in a remote backend (e.g., S3, Terraform Cloud).
- **Pros:**
  - Enables team collaboration.
  - Provides state locking and versioning.
- **Cons:**
  - Requires additional setup.

## When to Use Remote State
- When working in a team.
- When managing large or complex infrastructure.
- When you need state locking to prevent conflicts.

## Example: Switching to Remote State
To switch from local to remote state, configure a backend in your Terraform configuration:

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "path/to/my/state.tfstate"
    region = "us-east-1"
  }
}
