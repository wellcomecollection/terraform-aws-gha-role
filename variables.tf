variable "github_repository" {
  type        = string
  description = <<-EOT
    GitHub OIDC subject allowed to assume the role, written as the part after
    "repo:". Accepted shapes:
      org/repo:ref:refs/heads/main   one ref
      org/repo:pull_request          pull request runs
      org/repo:environment:prod      jobs with that environment key
      org/repo:*                     every run in the repo, including the above
  EOT

  validation {
    condition     = can(regex("^[^/:*]+/[^/:*]+:(\\*|ref:.*|pull_request|environment:.+)$", var.github_repository))
    error_message = "github_repository must be org/repo followed by a subject: ref:<ref>, pull_request, environment:<name>, or * for every run."
  }
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
