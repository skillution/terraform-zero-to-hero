###################################################
# Basic resources (S3 bucket, EC2 instance).
###################################################

###################################################
# Example S3 Bucket
###################################################
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Environment = "demo"
    CreatedBy   = "Terraform"
  }
}

###################################################
# Example EC2 Instance (using the default provider)
###################################################
resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  # Additional fields: security groups, key_name, etc.

  tags = {
    Name        = "MyDemoInstance"
    Environment = "demo"
  }
}

###################################################
# (Optional) Another resource using aliased provider
###################################################
resource "aws_s3_bucket" "secondary_bucket" {
  provider = aws.secondary

  bucket = "${var.bucket_name}-secondary"
  # must be a globally unique name as well

  tags = {
    Environment = "demo"
    Region      = var.secondary_region
  }
}
