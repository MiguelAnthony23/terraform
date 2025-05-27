variable "client_id" {
  description = "Azure Client ID (App ID)"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret (App Secret)"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
