
# Integrating Terraform with CI/CD Pipelines - GitHub Actions (Part-2)

## 4. Separate Environments (Optional but Recommended)

To avoid accidentally deploying to production, you can create separate workflows or jobs for **development**, **staging**, and **production**. There are a few ways to do this:

### 4.1 Use Terraform Workspaces

1. **Create a new workspace**:
   ```bash
   terraform workspace new dev
   terraform workspace new prod

### 4.2 Use Different Folders

Create separate folders like `environments/dev` and `environments/prod`, each containing its own Terraform configuration.  
Update your GitHub Actions workflow to **run Terraform commands in the relevant folder**.

---

### 4.3 Use GitHub Environments

GitHub allows you to define environments (e.g., production) that can require **manual approvals**, **environment-specific secrets**, or **restricted access**.  
Configure these under **Settings > Environments** in your repository.

---

## 5. Add Manual Approval (for Production)

For production deployments, it’s often wise to add a **manual approval step**. With GitHub Actions, you can:

- Use **GitHub Environments** and configure required reviewers in **Settings > Environments**.  
- Create a **dedicated job** that requires review before deploying to production.

Below is a simplified example of a multi-job workflow:

```yaml
jobs:
  terraform-dev:
    runs-on: ubuntu-latest
    steps:
      # ... Terraform init, plan, apply for dev ...

  terraform-prod:
    needs: terraform-dev
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v1

      # ... configure credentials ...

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        run: terraform apply -auto-approve
```

In the **Settings > Environments > production** section, you can configure **Required reviewers** or **wait timers** to enforce approvals before this job can proceed.

---

## Best Practices

### Separate State for Each Environment
- Use **remote state** (e.g., AWS S3 or Terraform Cloud) to store and lock state files.  
- Keep **development**, **staging**, and **production** states isolated to prevent cross-environment interference.

### Version Control Your Terraform Code
- Only merge changes into the **main branch** after they pass CI checks and are peer-reviewed.  
- Use **pull requests** to discuss, review, and test any modifications.

### Automate Testing
- Use `terraform validate` to catch syntax errors early.  
- Use `terraform fmt` to maintain consistent code formatting.  
- For larger projects, incorporate **static code analysis** or policies like **Sentinel** for advanced compliance checks.

### Manual Approval for Production
- Always require a **manual review** or a dedicated approval process before applying changes to critical environments.  
- This helps avoid costly mistakes or downtime.

### Monitor and Audit
- Keep logs of your GitHub Actions runs for traceability.  
- Monitor cloud usage and resource creation/deletion to ensure changes align with expectations.

---

## Conclusion

By setting up a robust CI/CD pipeline with **GitHub Actions**, you can **streamline** your Terraform workflows and ensure **consistent, reliable** infrastructure changes. From automated tests (`terraform plan` on every push) to protected deployments (manual approvals for production), these best practices help you maintain **control** and **confidence** in your **Infrastructure as Code** journey.
