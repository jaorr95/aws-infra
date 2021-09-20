resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_object" "files" {

  count   = var.object_files_quantity
  bucket  = aws_s3_bucket.bucket.id
  key     = "file${count.index + 1}.txt"
  content = local.content_file
  etag    = md5(local.content_file)
  acl     = var.files_acl
}
