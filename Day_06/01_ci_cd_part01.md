# Integrating Terraform with CI/CD Pipelines - GitHub Actions (Part-1)

Implementing CI/CD (Continuous Integration/Continuous Deployment) for Terraform ensures that infrastructure changes are applied **consistently**, **quickly**, and **reliably**. 

By automating tests and deployment steps, teams can:

- **Catch errors early** with automated checks.  
- **Enforce best practices** through version control and peer reviews.  
- **Maintain a clear audit trail** of who changed what and when.

---

## Creating a GitHub Actions Workflow for Terraform

This guide will help you set up a CI/CD pipeline for Terraform using **GitHub Actions**.

### 1. Prepare Your Repository

1. **Create or open your Terraform project repository** on GitHub.
2. **Organize your Terraform files** in a folder structure that’s easy to understand (for example, `main.tf`, `variables.tf`, `outputs.tf` at the root of your project).

### 2. Store Your Secrets in GitHub

To allow GitHub Actions to communicate with your cloud provider (e.g., AWS, Azure, GCP), set up the necessary credentials as **GitHub Actions secrets**.

1. In your GitHub repository, go to **Settings** > **Secrets and variables** > **Actions**.  
2. Click **New repository secret** and add the required environment variables (e.g., `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).  
3. **Do not store secrets** in the workflow file or repository code. Always use GitHub’s encrypted secrets.

### 3. Create the Workflow File

Create a workflow file in your repository under `.github/workflows/terraform-ci-cd.yml`. Below is an example workflow that:

- Checks out the repository code.  
- Sets up Terraform.  
- Configures environment variables for your cloud credentials.  
- Runs `terraform init`, `terraform plan`, and optionally `terraform apply`.

```yaml
name: Terraform CI/CD

on:
  push:
    branches: [ "main" ]

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Configure AWS Credentials
        if: ${{ secrets.AWS_ACCESS_KEY_ID && secrets.AWS_SECRET_ACCESS_KEY }}
        run: |
          echo "Configuring AWS Credentials..."
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: us-east-1

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan

      # Optional step to automatically apply changes; 
      # consider using a separate job or a manual approval process for production
      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
```

#### Additional Notes and Best Practices

> **Note**  
> Update `AWS_DEFAULT_REGION` according to your preferred region.  
> If you’re using a different cloud provider (Azure, GCP, etc.), configure the appropriate environment variables and provider settings.

