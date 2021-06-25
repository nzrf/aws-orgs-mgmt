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

resource "aws_organizations_organizational_unit" "application" {
    name =  "application"
    parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "infrastructure" {
    depends_on = [aws_organizations_organization.org]
    name =  "infrastructure"
    parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "app_nonprod" {
    name =  "nonprod"
    parent_id = aws_organizations_organizational_unit.application.id
}




#output "nonprod_id" {
#  value = app_nonprod
#}


module "aws_orgs" {
  source = "./modules/aws_orgs"
  #require_s3_encryption_target_ids =  [ aws_organizations_organizational_unit.application.nonprod.id ] 
  require_s3_encryption_target_ids =  [ ] 
}