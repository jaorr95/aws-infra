output "instance_ip_addr" {
  value = aws_instance.public_instance[*].public_ip
}

output "dns_alb" {
  value = aws_elb.lb_files.dns_name
}

output "content_files_s3" {
  value = local.content_file
}

output "object_files_quantity" {
  value = var.object_files_quantity
}

output "defined_bucket_name" {
  value = var.bucket_name
}