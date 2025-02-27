# Introduction to Terraform Cloud

**Terraform Cloud** is a SaaS offering by HashiCorp that streamlines the way teams collaborate on Infrastructure as Code. It provides **remote state management**, **version control integration**, **policy enforcement**, and other features that simplify and secure the Terraform workflow at scale.

---

## Key Features

1. **Remote State Management**  
   - Store and lock your Terraform state files in a secure, centralized location.  
   - Prevent state file conflicts and ensure only one person or process can change state at a time.

2. **Team Collaboration**  
   - Enable multiple users to work on the same Terraform configuration with confidence.  
   - Integrate with GitHub, GitLab, or other version control systems to trigger plans and applies on pull requests.

3. **Policy Enforcement**  
   - Use **Sentinel**, a policy-as-code framework, to enforce compliance and security best practices.  
   - Automatically check every Terraform run for policy violations.

4. **Scalability and Observability**  
   - Run Terraform operations in the cloud without needing local compute resources.  
   - Gain insights into run logs, plan outputs, and change history in a shared environment.

---

## Example: Configuring Terraform Cloud

Below is a sample **HCL** snippet that configures Terraform to use **Terraform Cloud**. Make sure you have already created your organization and workspace on Terraform Cloud.

```hcl
terraform {
  cloud {
    organization = "my-org"

    workspaces {
      name = "my-workspace"
    }
  }
}
