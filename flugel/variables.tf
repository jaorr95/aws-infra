# LOAD BALANCER
variable "alb_name" {
  type        = string
  description = "Load balancer name"
  default     = "lb-flugel"
}


# EC2
variable "public_instance_quantity" {
  type        = number
  description = "Quantity of public instances"
  default     = 2

}

variable "public_instance_type" {
  type        = string
  description = "Type of public instances"
  default     = "t3.micro"

}

variable "public_instance_prefix_name" {
  type        = string
  description = "Prefix name of public instances"
  default     = "flugel-public-"

}

# IAM
variable "policy_name_s3" {
  type        = string
  description = "Policy name for s3 access "
  default     = "flugelS3OnlyAccess"

}

variable "role_name_ec2" {
  type        = string
  description = "Role name for s3 access"
  default     = "Ec2RoleAccessS3"

}

variable "instance_profile_name" {
  type        = string
  description = "Instance profile for public instances"
  default     = "Ec2RoleAccessS3InstanceProfile"

}

# S3
variable "bucket_name" {
  type        = string
  description = "Instance profile for public instances"
  default     = "flugel-files"

}

variable "bucket_acl" {
  type        = string
  description = "Instance profile for public instances"
  default     = "private"

}

variable "object_files_quantity" {
  type        = number
  description = "Instance profile for public instances"
  default     = 2

}

variable "files_acl" {
  type        = string
  description = "Instance profile for public instances"
  default     = "private"

}

# SECURITY GROUPS

variable "sg_traffic_for_internet" {
  type        = any
  description = "Security group for allow http"
  default = {
    name        = "http-from-internet"
    description = "Security group for allow http"
    ingress = [{
      description      = "http from internet"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = null
      self             = null
    }]
  }

}

variable "sg_traffic_for_vpc" {
  type        = any
  description = "Security group for allow traffic inside vcp"
  default = {
    name        = "http-from-vpc"
    description = "Security group for allow traffic inside vcp"
    ingress = [{
      description      = "Allow http traffic inside vpc"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/16"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = null
      self             = null
    }]
  }
}

variable "sg_default_egress" {
  type        = any
  description = "Default egress for segurity groups"
  default = {
    description      = "Default egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = null
    self             = null
  }
}

# VPC
variable "vpc_name" {
  type        = string
  description = "Name of vpc"
  default     = "vpc-flugel"

}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of vpc"
  default     = "10.0.0.0/16"

}

variable "vpc_public_subnet_bitmask" {
  type        = number
  description = "CIDR of vpc"
  default     = 8

}

variable "vpc_public_subnet_start" {
  type        = number
  description = "CIDR of vpc"
  default     = 1

}

