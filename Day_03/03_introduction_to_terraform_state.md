# Introduction to Terraform State

## What is Terraform State?
Terraform state (`terraform.tfstate`) is a JSON file that maps resources in your configuration to real-world infrastructure. It tracks metadata, dependencies, and resource attributes.

## Why is State Important?
- Enables Terraform to determine what changes need to be made during `terraform apply`.
- Tracks resource dependencies and attributes.
- Ensures idempotency (applying the same configuration multiple times results in the same state).

## State File Structure

To view the state file of your project, run `terraform show` command

The state file contains resource mappings, metadata, and outputs. Here's an example:

```json
{
  "version": 4,
  "terraform_version": "1.3.0",
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "web",
      "provider": "provider.aws",
      "instances": [
        {
          "attributes": {
            "ami": "ami-123456",
            "instance_type": "t2.micro"
          }
        }
      ]
    }
  ]
}
