resource "aws_s3_bucket" "this" {
  bucket = lower(replace("${var.prefix}-bucket-${var.environment}", "_", "-"))
  force_destroy = false

  tags = {
    Name        = "${var.prefix}-bucket-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
