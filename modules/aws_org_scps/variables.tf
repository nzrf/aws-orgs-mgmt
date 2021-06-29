variable "require_s3_encryption_target_ids" {
  description = "Target ids (Organizational Unit) to attach an SCP requiring S3 encryption"
  type        = list(string)
  default     = []
}

variable "ai_data_services_optout_target_ids" {
  description = "Target ids (Organizational Unit) to attach an SCP requiring S3 encryption"
  type        = list(string)
  default     = []
}

variable "deny_leaving_org_target_ids" {
  description = "Target ids (Organizational Unit) to attach an SCP to deny leaving org"
  type        = list(string)
  default     = []
}
variable "limit_aws_regions_target_ids" {
  description = "Target ids (Organizational Unit) to attach an SCP to deny services outside us-east-1 and us-east-2"
  type        = list(string)
  default     = []
}

