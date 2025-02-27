###################################################
# Input Variables
###################################################
variable "default_region" {
  type        = string
  description = "Primary AWS region for the default provider."
  default     = "us-east-1"
}

variable "secondary_region" {
  type        = string
  description = "Secondary AWS region for aliased provider."
  default     = "us-west-2"
}

variable "bucket_name" {
  type        = string
  description = "Unique name for the S3 bucket."
  default     = "s3-bucket-12345"
}
