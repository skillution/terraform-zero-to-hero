###################################################
# Root Module Orchestration
###################################################
terraform {
  required_version = ">= 1.0.0"

  # Example of requiring certain providers
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
