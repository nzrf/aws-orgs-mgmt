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