data "aws_organizations_organization" "org" {
}

data "aws_organizations_organizational_units" "ou" {
  parent_id = data.aws_organizations_organization.org.roots[0].id
}
#output "accounts" {

#  value = data.aws_organizations_organization.org.accounts
#}
#output "parent_id" {
#  value = data.aws_organizations_organization.org.roots[0].id
#}