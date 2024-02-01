resource "aws_iam_user" "terraform" {
  name = "terraform"
}

resource "aws_iam_policy" "kms_describe_policy" {
  name        = "kms_describe_policy"
  description = "Policy for describing KMS keys"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "kms:DescribeKey",
        Resource = "arn:aws:kms:us-east-1:943467634864:key/e9600b6c-2805-4a57-8032-a9ddc0edbbd4",
      },
    ],
  })
}

resource "aws_iam_user_policy_attachment" "kms_describe_attachment" {
  user       = aws_iam_user.terraform.name
  policy_arn = aws_iam_policy.kms_describe_policy.arn
}


