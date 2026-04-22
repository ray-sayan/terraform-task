# Create S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "sayan-terraform-bucket-12345" 

  tags = {
    Name        = "terra-bucket"
    Environment = "dev"
  }
}

# Block Public Access (SECURE)
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# (Optional) Ownership Controls
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Upload File to S3
resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"          # file name in S3
  source = "index.html"          # local file path
  etag   = filemd5("index.html")

  content_type = "text/html"
}
