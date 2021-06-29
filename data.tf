data "aws_organizations_organization" "org" {
}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}

data "aws_organizations_organization" "testacct" {
  accounts_id = data.aws_organizations_organization.org.accounts
}