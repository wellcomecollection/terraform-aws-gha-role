// The repositories that are allowed to assume the github_actions_assume_role
variable "github_repository" {
  type = string
}

variable "github_oidc_provider_arn" {
  type = string
}

variable "role_name" {
  type = string
}

variable "policy_document" {
  type = string
}