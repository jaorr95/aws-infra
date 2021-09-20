resource "aws_iam_role_policy" "s3_policy" {
  name = var.policy_name_s3
  role = aws_iam_role.ec2_role.id


  policy = templatefile("${path.module}/config/iam/policy-s3-access.tpl", {bucket_name = var.bucket_name})
}

resource "aws_iam_role" "ec2_role" {
  name = var.role_name_ec2

  assume_role_policy = file("${path.module}/config/iam/assume-role-ec2.json")
}

resource "aws_iam_instance_profile" "ec2_role_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ec2_role.name
}
