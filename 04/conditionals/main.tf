provider "aws" {
    region = "ap-northeast-2"
}

variable "is_jinju" {
  type        = bool
  default     = "false"
}

locals {
    message = var.is_jinju ? "Hello, Jinju!" : "Who are you?"
}

output "message" {
    value = local.message
}
