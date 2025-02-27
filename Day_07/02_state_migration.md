## 01_state_migration.md: Migrating and Refactoring Terraform State

### Why Refactor Terraform State?
As your infrastructure grows, you may need to:
- Rename resources.
- Move resources between modules.
- Split or merge state files.

Terraform provides tools to safely migrate and refactor state without disrupting your infrastructure.

---

### 1. Renaming a Resource

When you change a resource name in the configuration, you should update the Terraform state to match. If you don’t, Terraform might try to recreate the resource under the new name or remove the old resource. The following command updates the resource name in your state file:

```bash
terraform state mv aws_instance.old_name aws_instance.new_name
```

This tells Terraform, “The resource previously tracked as aws_instance.old_name is now aws_instance.new_name.” The underlying infrastructure remains untouched.

---

### 2: Moving a Resource to a Module

If you decide to restructure your configurations or move resources into (or out of) modules, you can use the same terraform state mv command:

```bash
terraform state mv aws_instance.example module.my_module.aws_instance.example
```

This command tells Terraform that the resource aws_instance.example now resides inside module.my_module, preserving its current state so it does not get destroyed and recreated.
