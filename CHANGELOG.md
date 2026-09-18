# CHANGELOG

## v2.1.0 - 2026-09-18

New `github_repositories`, a list of subjects any one of which may assume the role. A job that names an `environment` presents `environment:<name>` as its OIDC subject rather than the ref, so a workflow that publishes from main and then deploys through an environment cannot be described by one subject. `github_repository` is unchanged and still works on its own.

## v2.0.0 - 2026-09-16

`github_repository` must now include the ref part of the OIDC subject, for example `org/repo:ref:refs/heads/main` or `org/repo:*`. A bare repository name used to default to every ref and is now rejected by validation.

## v1.0.0 - 2025-02-05

Initial release.  
This is based on the version of the github_repo_role module in [aws-account-infrastructure@f0f948f](https://github.com/wellcomecollection/aws-account-infrastructure/commit/f0f948f07ae386cde9ec115e50482dcda9500e59).

## v0.0.1 - 2024-02-04

Initial tagged version.