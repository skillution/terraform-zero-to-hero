# Terraform Configuration File Structure

In a **Terraform project**, we will have multiple configuration files, each with a specific purpose.

To become an expert in Terraform, it is very much required to learn these configuration files and how they can help us structure our project.

**Here are some key configuration files of a terraform project and their purpose**

| File | Purpose |
|------|---------|
| **`main.tf`** | Defines resources and infrastructure components. |
| **`variables.tf`** | Declares input variables for customization. |
| **`outputs.tf`** | Defines output values to extract information after deployment. |
| **`terraform.tfvars`** | Stores variable values (not recommended for sensitive data). |
| **`provider.tf`** | Declares cloud providers (AWS, Azure, GCP, etc.). |
| **`backend.tf`** | Configures remote state storage (S3, Terraform Cloud). |


**Here is an Example Terraform Project Structure:**

```cmd
terraform-project/
│── main.tf             # Main infrastructure definition
│── variables.tf        # Input variables
│── outputs.tf          # Output values
│── provider.tf         # Cloud provider configuration
│── terraform.tfvars    # Variable values (optional)
│── backend.tf          # Remote state configuration
│── modules/            # Reusable Terraform modules
│── .terraform/         # Terraform initialization directory
│── .terraform.lock.hcl # Dependency lock file
│── terraform.tfstate   # State file (avoid committing this!)
```
