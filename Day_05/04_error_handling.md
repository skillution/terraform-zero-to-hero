
## Debugging and Error Handling in Terraform

Terraform configurations can become complex as you add resources, variables, and modules. 

Because of this complexity, **debugging and error handling** are critical parts of the development and deployment process.

---

### Common Terraform Commands for Error Handling

1. **`terraform validate`**  
   - Checks your configuration for syntax errors and basic logical issues.  
   - Run this command frequently during development.

2. **`terraform plan`**  
   - Shows you the changes Terraform intends to make.  
   - Can reveal issues like references to non-existent resources or incorrect variable types.

3. **`terraform apply`**  
   - Executes the changes.  
   - Combine with `-auto-approve` (in non-production environments) or review the plan manually before applying to avoid surprises.

4. **`terraform destroy`**  
   - Removes all resources defined in your configuration.  
   - Useful for cleaning up test environments when they are no longer needed.

---

### Example Resource with Basic Validation

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}

```

- The **`terraform validate`** command ensures the syntax is correct.  
- The **`terraform plan`** command previews what Terraform will create or update before you run `apply`.

---

### Debugging Techniques

#### Terraform Console
Use `terraform console` to evaluate expressions, test variable values, or quickly debug issues in your configuration.

#### Logging and Verbose Output
You can set the `TF_LOG` environment variable to different levels (`TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`) for more detailed logs.

Example:

```bash
export TF_LOG=DEBUG
terraform plan
```

Remember to unset `TF_LOG` when you’re done to reduce noise.

---

### Check Variable Types and Defaults
- Make sure that any default values match the data type declared for your variables.  
- Use [custom variable validation](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules) to catch invalid inputs at an early stage.

---

### Terraform Graph

This can help you visualize resource dependencies.

```bash
terraform graph | dot -Tpng > graph.png
```

Especially helpful to see where a problem might be originating in complex configurations.
