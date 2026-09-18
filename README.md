# terraform-aws-gha-role

This module is for creating roles that the specified `github_repository` is allowed to assume in order to perform certain actions on our AWS resources.

```hcl
module "gha_do_something_role" {
  source = "github.com/wellcomecollection/terraform-aws-gha-role?ref=v1.0.0"

  policy_document           = data.aws_iam_policy_document.gha_do_something.json
  github_repository         = "wellcomecollection/catalogue-api:ref:refs/heads/main"
  role_name                 = "do_something"
  github_oidc_provider_arn  = data.terraform_remote_state.aws_account.outputs.github_openid_connect_provider_arn
}
```
`github_repository`: the GitHub OIDC subject allowed to assume the role, written as the part after `repo:`. Use `org/repo:ref:refs/heads/main` for a role that deploys, `org/repo:pull_request` or `org/repo:environment:<name>` for those runs, or `org/repo:*` for every run in the repository. The subject part is required so that a wide-open role is a deliberate choice.  
`github_repositories`: several subjects, any one of which may assume the role, replacing `github_repository` where it is set. A job that names an `environment` presents `environment:<name>` rather than the ref, so a workflow that publishes from main and then deploys through an environment needs both listed:

```hcl
  github_repositories = [
    "wellcomecollection/catalogue-api:ref:refs/heads/main",
    "wellcomecollection/catalogue-api:environment:stage",
    "wellcomecollection/catalogue-api:environment:prod",
  ]
```

`policy_document`: the `aws_iam_policy_document` that describes which actions the Github runner is allowed to perform.  
`role_name`: describes what the role is for, formatted by the module as `gha-${var.role_name}-`.  
`github_oidc_provider_arn`: GitHub OIDC Provider relationships exist in each AWS account, which outputs its `github_openid_connect_provider_arn`. Pull in the relevant account's remote state to access it. Examples [here](https://github.com/wellcomecollection/aws-account-infrastructure/blob/main/accounts/platform/terraform.tf)