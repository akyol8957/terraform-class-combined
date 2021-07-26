resource "aws_key_pair" "automation" {
  key_name   = "automation"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
      Name = "DevOps"
  }
}

resource "aws_key_pair" "automation2" {
  key_name   = "automation2"
  public_key = file("~/.ssh/id_rsa.pub")
  tags = {
      Name = "DevOps"
  }
}