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

data "aws_iam_policy_document" "ai_data_services_opt_out" {

}

resource "aws_organizations_policy" "ai_data_services_opt_out" {
  name        = "ai-data_services-optout"
  description = "Opt Out of data services for all services and accounts"
  type =  "AISERVICES_OPT_OUT_POLICY"
  content = <<EOT
  {
    "services": {
      "default": {
        "opt_out_policy": {
          "@@operators_allowed_for_child_policies": ["@@none"],
          "@@assign": "optOut"
        }
      }
    }
  }
  EOT 
}

#resource "aws_organizations_policy" "ai_data_services_opt_out" {
#  name        = "ai-data_services-optout"
#  description = "Opt Out of data services for all services and accounts"
#  content = <<EOT
#  EOT 
#}  

resource "aws_organizations_policy_attachment" "require_data_services_opt_out" {
  count = length(var.ai_data_services_optout_ids)

  policy_id = aws_organizations_policy.ai_data_services_opt_out.id
  target_id = element(var.ai_data_services_optout_ids.*, count.index)
}