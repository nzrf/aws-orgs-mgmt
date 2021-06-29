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


module "aws_org_scps" {
  source = "./modules/aws_org_scps"
  #require_s3_encryption_target_ids =  [ aws_organizations_organizational_unit.application.nonprod.id ] 
  depends_on = [aws_organizations_organization.org]
  require_s3_encryption_target_ids =  [ local.application-nonprod ] 
  ai_data_services_optout_target_ids =  [ local.root ] 
}