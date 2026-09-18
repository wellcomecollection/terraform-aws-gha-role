RELEASE_TYPE: minor

New `github_repositories`, a list of subjects any one of which may assume the role. A job that names an `environment` presents `environment:<name>` as its OIDC subject rather than the ref, so a workflow that publishes from main and then deploys through an environment cannot be described by one subject. `github_repository` is unchanged and still works on its own.
