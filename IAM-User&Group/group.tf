resource "aws_iam_group" "developers" {
  name = each.key  
  path = "/users/"
  for_each = toset([
    "sales",
    "marketing",
    "billing",
  ])
}
