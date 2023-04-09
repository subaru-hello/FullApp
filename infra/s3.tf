resource "aws_s3_bucket" "front_bucket" {
  bucket = "front-bucket-name"
  acl    = "private"

   website {
    index_document = "index.html"
  }
}


resource "aws_s3_bucket_policy" "nextjs_bucket_policy" {
  bucket = aws_s3_bucket.front_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "s3:GetObject"
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.front_bucket.arn}/*"
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.nextjs_oai.id}"
        }
       }
    ] 
  })
}
