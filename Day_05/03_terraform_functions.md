
## Terraform Built-in Functions

Terraform includes **built-in functions** that help you transform and manage data. 

These functions let you do things like modify strings, work with lists, handle maps, and perform arithmetic—all within your Terraform code. By using these functions, you can avoid writing repetitive or overly complicated logic.

---

## Common Function Categories

1. **String Functions**  
   - **`upper()`** / **`lower()`**: Convert text to uppercase/lowercase.  
   - **`concat()`**: Join multiple strings.  
   - **`replace()`**: Replace occurrences of a substring.

2. **List (or Array) Functions**  
   - **`length()`**: Get the number of items in a list or map.  
   - **`slice()`**: Extract a portion of a list.  
   - **`element()`**: Return the item at a specified index in a list.

3. **Map Functions**  
   - **`merge()`**: Combine two or more maps into one.  
   - **`keys()`** / **`values()`**: Get all keys or all values from a map.

4. **Numeric Functions**  
   - **`max()`** / **`min()`**: Return the maximum or minimum value from a set of numbers.  
   - **`abs()`**: Return the absolute value of a number.

5. **Other Useful Functions**  
   - **`coalesce()`** / **`coalescelist()`**: Return the first non-null or non-empty value.  
   - **`compact()`**: Remove `null` or empty values from a list.

You can find a full list in the [Terraform documentation on built-in functions](https://developer.hashicorp.com/terraform/language/functions).

---

## Examples

### Example 1: String and List Manipulation

In this example, upper(var.environment) converts dev to DEV. And slice(var.subnets, 0, 2) takes the items from index 0 up to (but not including) index 2, resulting in the first two subnets.

```hcl
variable "environment" {
  type    = string
  default = "dev"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-12345", "subnet-67890", "subnet-abcde"]
}

locals {
  # Convert environment name to uppercase and append "-instance"
  instance_name = "${upper(var.environment)}-instance"

  # Slice the first two subnets from the variable subnets list
  main_subnets = slice(var.subnets, 0, 2)
}

```

---

### Example 2: Merging Maps

In this example, merge() combines two maps (default_tags and extra_tags) into a single map.

aws_instance automatically uses all tags from both maps.

```hcl
variable "default_tags" {
  type    = map(string)
  default = {
    Project  = "MyApp"
    Owner    = "DevOps"
  }
}

variable "extra_tags" {
  type    = map(string)
  default = {
    Env   = "Production"
    Dept  = "Engineering"
  }
}

locals {
  combined_tags = merge(var.default_tags, var.extra_tags)
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = local.combined_tags
}

```
