variable "require_s3_encryption_target_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP requiring S3 encryption"
  type        = list(string)
  default     = []
}

variable "ai_data_services_optout_ids" {
  description = "Target ids (AWS Account or Organizational Unit) to attach an SCP requiring S3 encryption"
  type        = list(string)
  default     = []
}
