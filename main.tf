resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
#    "config.amazonaws.com",
  ]
  # Eanble all features in AWS Orgs
  feature_set = "ALL"
  # Enable policy types i.e service control policies, tag policies etc. 
  enabled_policy_types = [
    "AISERVICES_OPT_OUT_POLICY",
    "SERVICE_CONTROL_POLICY"
  ]
}

#Setting up application top level org ou. Need to figure out how to make this a module.
resource "aws_organizations_organizational_unit" "application" {
    # OU Must be created before childen n the ou can be created
    depends_on = [aws_organizations_organization.org]
    name =  "application"
    parent_id = aws_organizations_organization.org.roots[0].id
}

#Setting up infrastructure top level org ou. Need to figure out how to make this a module.
resource "aws_organizations_organizational_unit" "infrastructure" {
    # OU Must be created before childen n the ou can be created
    depends_on = [aws_organizations_organization.org]
    name =  "infrastructure"
    parent_id = aws_organizations_organization.org.roots[0].id
}

#Setting up nonprod org unit under application. Need to figure out how to make this more clear or a module.
resource "aws_organizations_organizational_unit" "app_nonprod" {
    # OU Must be created before childen n the ou can be created
    depends_on = [aws_organizations_organizational_unit.application]
    name =  "nonprod"
    parent_id = aws_organizations_organizational_unit.application.id
}


module "aws_org_scps" {
  source = "./modules/aws_org_scps"
  #require_s3_encryption_target_ids =  [ aws_organizations_organizational_unit.application.nonprod.id ] 
  depends_on = [aws_organizations_organization.org]
  require_s3_encryption_target_ids =  [ local.application] 
}