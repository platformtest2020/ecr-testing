module "ecr_github_pull_through_cache_secret" {
  #checkov:skip=CKV_TF_1:Module registry does not support commit hashes for versions
  #checkov:skip=CKV_TF_2:Module registry does not support tags for versions

  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "2.1.0"

  name        = "ecr-pullthroughcache/github"
  description = "Short-lived GitHub Container Registry credentials refreshed through Octo STS"

  # The value is populated by the GitHub Actions Octo STS refresh workflow.
  # Keep Terraform from replacing the active token on subsequent applies.
  secret_string         = jsonencode({
    username = "octo-sts"
    password = "CHANGEME"
  })
  ignore_secret_changes = true

  tags = local.tags
}
