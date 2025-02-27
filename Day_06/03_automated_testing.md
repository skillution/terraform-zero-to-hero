## Automated Testing of Terraform Configurations

Automated testing ensures your Terraform configurations are **valid**, **secure**, and **performant** before deploying to production.

---

### 1. Static Analysis

#### 1.1 Terraform Fmt

Consistent code style improves readability and reduces code review friction.

`terraform fmt` Automatically formats your Terraform code to a consistent style.

- **Usage**:

  ```bash
  terraform fmt
  ```

#### 1.2 terraform validate

Terraform validate helps to Quickly catch typos, missing variables, or incorrect argument references.

- **Usage**:

    ```bash
    terraform validate
    ```

#### 1.3. Linting with TFLint

`TFLint` is a popular linting tool that checks your Terraform code for potential issues, such as deprecated arguments or missing attributes in providers. It catches provider-specific issues that terraform validate might miss.

**Installation:** [TFLint GitHub Repo](https://github.com/terraform-linters/tflint)

**Usage:**

```bash
tflint
```

#### 1.4. Security Scanning (Checkov or Similar Tools)

`checkov` scans Terraform code for security and compliance misconfigurations, policy violations (e.g., checking if an S3 bucket is publicly accessible).

**Installation:** [Checkov GitHub Repo](https://github.com/bridgecrewio/checkov)

**Usage:**

```bash
checkov -d .
```

---

### 2. Integration Testing with Terratest

For thorough testing, you can deploy infrastructure in a temporary environment and run real-world verifications:

Terratest is written in Go: Allows you to write tests that provision Terraform resources, then verify their functionality (e.g., checking if an EC2 instance is reachable).

**Key Commands:**

```go

// Example Go snippet
terraform.InitAndApply(t, opts)   // Deploy the infrastructure
terraform.Destroy(t, opts)  // Clean up resources at the end of the test

```

**Example:**

1. Create a Test File: In Go, you might have a file named `terraform_integration_test.go` with the following snippet:

```go

package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
  "github.com/stretchr/testify/assert"
)

func TestTerraformExample(t *testing.T) {
  opts := &terraform.Options{
    TerraformDir: "../examples/terraform-example",
  }

  // Clean up resources at the end of the test
  defer terraform.Destroy(t, opts)

  // Deploy the infrastructure
  terraform.InitAndApply(t, opts)

  // Fetch output variables
  output := terraform.Output(t, opts, "instance_ip")

  // Run your assertions
  assert.NotEmpty(t, output)
}

```

2. **Run the Test**:

```bash

go test -v

```

3. **Automate:** 

Integrate these steps into your CI/CD pipeline to run after every commit or pull request.

---

## 3. CI/CD Integration

### 3.1 Example with GitHub Actions

A typical workflow might include:

1. Check out code
2. Lint with tflint
3. Validate with terraform validate
4. Plan with terraform plan
5. (Optional) Test with Terratest in a temporary environment
6. (Optional) Approve for production deployment

```yaml

name: Terraform CI

on:
  pull_request:
    branches: [ "main" ]

jobs:
  terraform-tests:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repo
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v1

      - name: Run Terraform Fmt
        run: terraform fmt -check

      - name: Validate with Terraform
        run: terraform validate
        
      - name: Lint with TFLint  # Linting with TFLint
        run: tflint --init && tflint

      - name: Security Scan with Checkov    # Security Scanning
        run: checkov -d .

      - name: Terraform Plan
        run: terraform plan

# (Optional) Integration Tests - Terratest would be run via `go test`
    # - name: Run Terratest
    #   run: go test -v ./tests

```
