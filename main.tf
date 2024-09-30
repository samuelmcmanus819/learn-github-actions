resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket99999999999999999"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
} 