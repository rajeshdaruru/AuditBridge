variable "db_password" {
  description = "Demo fixture only — never a real credential. Set via TF_VAR_db_password if you ever need to run terraform validate with a value."
  type        = string
  default     = "unused-placeholder"
  sensitive   = true
}
