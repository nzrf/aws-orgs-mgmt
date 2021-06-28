data "aws_iam_policy_document" "require_s3_encryption" {
  statement {
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["*"]
    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }
  statement {
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["*"]
    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = [true]
    }
  }
}

resource "aws_organizations_policy" "require_s3_encryption" {
  name        = "require-s3-encryption"
  description = "Require that all Amazon S3 buckets use AES256 encryption"
  content     = data.aws_iam_policy_document.require_s3_encryption.json
}

resource "aws_organizations_policy_attachment" "require_s3_encryption" {
  count = length(var.require_s3_encryption_target_ids)

  policy_id = aws_organizations_policy.require_s3_encryption.id
  target_id = element(var.require_s3_encryption_target_ids.*, count.index)
}