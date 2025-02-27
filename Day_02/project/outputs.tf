#######################################################
# Outputs - for referencing important resource values.
#######################################################
output "s3_bucket_id" {
  description = "ID of the primary S3 bucket."
  value       = aws_s3_bucket.example.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance."
  value       = aws_instance.my_ec2.public_ip
}
