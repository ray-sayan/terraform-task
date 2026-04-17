# Create S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "sayan-terraform-bucket-12345" # must be globally unique

  tags = {
    Name = "terra-bucket"
  }
}

# Allow public access to bucket
resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}

# Upload file to S3
resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"          # file name in S3
  source = "index.html"          # local file path
  etag   = filemd5("index.html") # detect changes
}