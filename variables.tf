variable "github_repository" {
  type        = string
  default     = null
  description = <<-EOT
    GitHub OIDC subject allowed to assume the role, written as the part after
    "repo:". Accepted shapes:
      org/repo:ref:refs/heads/main   one ref
      org/repo:pull_request          pull request runs
      org/repo:environment:prod      jobs with that environment key
      org/repo:*                     every run in the repo, including the above
    Use github_repositories where a workflow presents more than one.
  EOT

  validation {
    condition     = var.github_repository == null || can(regex("^[^/:*]+/[^/:*]+:(\\*|ref:.*|pull_request|environment:.+)$", var.github_repository))
    error_message = "github_repository must be org/repo followed by a subject: ref:<ref>, pull_request, environment:<name>, or * for every run."
  }
}

variable "github_repositories" {
  type        = list(string)
  default     = []
  description = <<-EOT
    Several subjects, any one of which may assume the role. A job that names an
    environment presents environment:<name> instead of the ref, so a workflow
    that both publishes from main and deploys through an environment needs both
    listed. Same shapes as github_repository, which it replaces when set.
  EOT

  validation {
    condition = alltrue([
      for subject in var.github_repositories :
      can(regex("^[^/:*]+/[^/:*]+:(\\*|ref:.*|pull_request|environment:.+)$", subject))
    ])
    error_message = "each entry must be org/repo followed by a subject: ref:<ref>, pull_request, environment:<name>, or * for every run."
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
