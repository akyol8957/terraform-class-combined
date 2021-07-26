resource "aws_iam_user" "users" {
  name = each.key
  path = "/system/"
  for_each = toset([
    "bob",
    "tim",
    "sam",
    "ben",
    "lisa"
  ])
  tags = {
    Team = "DevOps"
  }
}
