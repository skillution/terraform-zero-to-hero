# Data Sources

## What are Data Sources?

Data sources in Terraform allow you to fetch and use information from external sources (e.g., cloud providers, APIs, or other Terraform configurations) within your Terraform code. 

Unlike resources, data sources do not create or modify infrastructure; they only read data.

Each Provider offers its own data sources.

## Why Use Data Sources?
Avoid Hardcoding: Fetch dynamic information (e.g., AMI IDs, VPC IDs) instead of hardcoding values.

Reuse Existing Resources: Reference resources created outside of Terraform or in other configurations.

Simplify Configurations: Reduce complexity by fetching data dynamically.

## Syntax of Data Sources
The syntax for defining a data source is:

```hcl
data "<provider>_<type>" "<name>" {
  # Arguments to filter or query the data
}
```

- **provider:** The provider name (e.g., aws, azurerm, google).
- **type:** The type of data source (e.g., ami, vpc, subnet).
- **name:** A unique name for the data source within your configuration.

---
## Example

Let’s say you want to fetch the latest Amazon Linux 2 AMI for an EC2 instance. Here is how we can do this with data sources:

**Step 1: Define the Data Source**

```hcl
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
```

**Step 2: Use the Data Source**
Now, use the fetched AMI ID in an EC2 instance resource:

```hcl
resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
}
```

*Explanation:*

The aws_ami data source fetches the latest Amazon Linux 2 AMI.

The most_recent = true argument ensures the latest AMI is selected.

The filter block narrows down the search to AMIs with a specific name pattern.
