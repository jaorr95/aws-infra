{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "${s3_bucket_arn}",
                "${s3_bucket_arn}/*"
            ],
            "Condition": {
                "StringNotLike": {
                    "aws:userId": [
                        "${role_ec2_id}:*",
                        "${root_account}",
                        "${terraform_user_id}"
                    ]
                }
            }
        }
    ]
}