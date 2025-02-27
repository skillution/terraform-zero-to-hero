# Terraform Workflow

The Terraform workflow is a set of steps you follow to **create**, **update**, and **manage** your infrastructure using Terraform.

---

It consists of four main commands: **init**, **plan**, **apply**, and **destroy**.

1. **terraform init:** Initializes your working directory by downloading the necessary provider plugins and setting up the backend for storing the state file.

2. **terraform plan:** Generates an execution plan showing what Terraform will do (e.g., create, update, or delete resources).

3. **terraform apply:** Applies the changes to your infrastructure based on the plan.

4. **terraform destroy:** Removes all resources managed by Terraform.

---

## Exmaple - Provision/Manage AWS S3 bucket :

- If you’re using AWS, **terraform init** command downloads the AWS provider plugin.

- If you’re adding an S3 bucket, **terraform plan** will show that a new bucket will be created.

- After reviewing the plan, running **terraform apply** will create the S3 bucket in your AWS account.

- If you no longer need the S3 bucket, **terraform destroy** will delete it. 

---

**We will practice this workflow in our next exercise where we will deploy our first aws resource with terraform**

---
