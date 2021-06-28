data "aws_iam_policy_document" "limit_aws_regions" {
  statement {
    effect    = "Deny"
    not_actions = [
      "iam:*",
      "organizations:*",
      "route53:*",
      "budgets:*",
      "waf:*",
      "cloudfront:*",
      "globalaccelerator:*",
      "importexport:*",
      "support:*",
      "sts:*"
    ]
    resources = ["*"]
    condition {
      test     = "StringNotEquals"
      variable = "aws:RequestedRegion"
      values   = [
        "us-east-1",
        "us-east-2"]
    }
  }
}

resource "aws_organizations_policy" "limit_aws_regions_policy" {
  name        = "limit-regions"
  description = "SCP to limit AWS regions to us-east-1 and us-east-2"
  content     = data.aws_iam_policy_document.limit_aws_regions.json
}

resource "aws_organizations_policy_attachment" "limit_aws_regions" {
  count = length(var.limit_aws_regions_target_ids)

  policy_id = aws_organizations_policy.limit_aws_regions_policy.id
  target_id = element(var.limit_aws_regions_target_ids.*, count.index)
}