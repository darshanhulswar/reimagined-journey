provider "aws" {
  region = var.aws_region
}

resource "aws_iam_group" "s3_access_group" {
  name = "s3-access-group"
}

resource "aws_iam_policy" "s3_rw_policy" {
  name        = "S3ReadWriteAccess"
  path        = "/"
  description = "S3 Read/Write access to a specific bucket"
  policy      = file("${path.module}/s3_policy.json")
}

resource "aws_iam_group_policy_attachment" "attach_policy" {
  group      = aws_iam_group.s3_access_group.name
  policy_arn = aws_iam_policy.s3_rw_policy.arn
}

resource "aws_iam_user" "users" {
  for_each = toset(var.iam_users)
  name     = each.value
}

resource "aws_iam_user_group_membership" "group_membership" {
  for_each = toset(var.iam_users)
  user     = aws_iam_user.users[each.key].name
  groups   = [aws_iam_group.s3_access_group.name]
}
