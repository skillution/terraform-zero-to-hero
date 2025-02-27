# Count

Let's say we want to create 3 aws instances using terraform, do we need 3 resource blocks for 3 aws_instances ? 

**NO,** we can use use count to create multiple instances of a resource with single configuration block:

Here is the sample resource block to create 3 aws ec2 instances using count:

```hcl
resource "aws_instance" "web" {
  count         = 3
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

We can also add conditional expressions to count for conditional resource creation.

In the below example, we create 3 instances in prod but only 1 in other environments using conditional expression with count.

```hcl
resource "aws_instance" "web" {
  count = var.environment == "prod" ? 3 : 1
  ami   = "ami-123456"
  instance_type = "t2.micro"
}
```
