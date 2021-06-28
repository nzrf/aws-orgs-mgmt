data "aws_iam_policy_document" "deny_leaving_org" {
  statement {
    effect    = "Deny"
    actions   = ["organizations:LeaveOrganization"]
    resources = ["*"]
  }
}

resource "aws_organizations_policy" "deny_leaving_org_policy" {
  name        = "deny-leaving-org"
  description = "Deny Accounts from leaving the org"
  content     = data.aws_iam_policy_document.deny_leaving_org.json
}

resource "aws_organizations_policy_attachment" "deny_leaving_org_policy" {
  count = length(var.deny_leaving_org_target_ids)

  policy_id = aws_organizations_policy.deny_leaving_org_policy.id
  target_id = element(var.deny_leaving_org_target_ids.*, count.index)
}