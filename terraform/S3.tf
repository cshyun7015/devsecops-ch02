resource "aws_s3_bucket" "S3Bucket" {
  bucket = "ib07441-s3bucket-devsecops"
  force_destroy = true
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "IB07441-S3Bucket-DevSecOps"
  }
}

resource "aws_s3_bucket_object" "S3_Bucket_Object" {
  bucket = aws_s3_bucket.S3Bucket.id
  key    = "app-version.json"
  source = "../app-version.json"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("../app-version.json")
}