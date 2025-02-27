# State Locking

### What is State Locking?
State locking prevents multiple users from modifying the state simultaneously. It ensures consistency and avoids conflicts.

### How State Locking Works
- Enabled by default in remote backends (e.g., S3 with DynamoDB, Terraform Cloud).
- Terraform acquires a lock before applying changes and releases it afterward.

### Example: S3 with DynamoDB for Locking
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "path/to/my/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
```
