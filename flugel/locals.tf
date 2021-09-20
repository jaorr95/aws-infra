locals {

  config_server = [
    {
      content = filebase64("${path.module}/config/server/app/Dockerfile")
      path    = "/etc/server/app/Dockerfile"
    },
    {
      content = filebase64("${path.module}/config/server/app/go.mod")
      path    = "/etc/server/app/go.mod"
    },
    {
      content = filebase64("${path.module}/config/server/app/go.sum")
      path    = "/etc/server/app/go.sum"
    },
    {
      content = filebase64("${path.module}/config/server/app/main.go")
      path    = "/etc/server/app/main.go"
    },
    {
      content = base64encode(templatefile("${path.module}/config/server/app/server.tpl", { bucket_name = var.bucket_name }))
      path    = "/etc/server/app/server.env"
    },
    {
      content = filebase64("${path.module}/config/server/docker-compose.yml")
      path    = "/etc/server/docker-compose.yml"
    }

  ]

  content_file = timestamp()

  bucket_policy_params = {
    s3_bucket_arn     = aws_s3_bucket.bucket.arn,
    role_ec2_id       = aws_iam_role.ec2_role.unique_id,
    root_account      = data.aws_caller_identity.current.account_id,
    terraform_user_id = data.aws_iam_user.terraform.user_id
  }
}