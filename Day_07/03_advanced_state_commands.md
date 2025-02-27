# Using terraform state Commands

### Why Use Advanced State Commands?
Terraform provides powerful **state commands** to help you manage, inspect, and troubleshoot your infrastructure’s state. These commands allow you to:

- **Inspect the current state** to see which resources Terraform is tracking.  
- **Modify the state file** to rename, move, or remove resources without changing the underlying infrastructure.  
- **Troubleshoot issues** and resolve mismatches (drift) between your configuration and the actual infrastructure.

---

### Example 1: Listing All Resources
To see every resource Terraform is tracking in the current state, use:

```bash
terraform state list
```

You’ll get a list of resource addresses like aws_instance.example or module.my_module.aws_instance.example, which you can use in other commands.

---

### Example 2: Inspecting a Resource

To view the details of a specific resource in the state file:

```bash
terraform state show aws_instance.example
```

Terraform will display information about the instance (e.g., AMI ID, instance type, tags), giving you insight into what exactly is tracked for that resource.

### Example 3: Removing a Resource

If you want Terraform to “forget” about a resource without actually deleting it from your cloud provider, you can remove it from the state:

```bash
terraform state rm aws_instance.example
```

Be cautious when using this command, as Terraform will no longer manage or update the resource once it’s removed from the state.
