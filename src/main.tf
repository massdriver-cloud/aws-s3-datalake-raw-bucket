resource "aws_s3_bucket" "main" {
  bucket        = var.md_metadata.name_prefix
  force_destroy = false
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    id     = "s3-raw-transition"
    status = "Enabled"

    transition {
      days          = var.bucket.lifecycle.transfer_s3_ia
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.bucket.lifecycle.transfer_s3_glacier
      storage_class = "GLACIER"
    }
  }
}
