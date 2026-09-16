RELEASE_TYPE: major

`github_repository` must now include the ref part of the OIDC subject, for example `org/repo:ref:refs/heads/main` or `org/repo:*`. A bare repository name used to default to every ref and is now rejected by validation.
