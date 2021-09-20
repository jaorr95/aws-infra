# S3
variable "bucket_name" {
  type        = string
  description = "Instance profile for public instances"
  default     = "flugel-files"

}

variable "bucket_acl" {
  type        = string
  description = "Instance profile for public instances"
  default     = "public-read"

}

variable "object_files_quantity" {
  type        = number
  description = "Instance profile for public instances"
  default     = 2

}

variable "files_acl" {
  type        = string
  description = "Instance profile for public instances"
  default     = "public-read"

}