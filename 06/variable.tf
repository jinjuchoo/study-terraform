variable "name" {
  description = "The name used to namespace all the resources created by this module"
  type        = string
  default     = "ec2-iam-role-example"
}

variable "bucket_name" {
  type        = string
  default     = "jinju-tfstudy-credexample"
  description = "bucket name"
}