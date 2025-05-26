variable "iam_users" {
  type        = list(string)
  description = "List of IAM usernames to create"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
