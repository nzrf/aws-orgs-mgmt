variable "require_s3_encryption_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP requiring S3 encryption"
  type        = list(string)
  default     = []
}


variable "service_access_principals" {
  description = "List of org services to enable e.g. cloudtrail.amazonaws.com, config.amazonaws.com"
  type        = list(string)
  default     = []
}

variable "services_policies_types" {
  description = "List of org services to enable e.g. AISERVICES_OPT_OUT_POLICY, SERVICE_CONTROL_POLICY"
  type        = list(string)
  default     = []
}
