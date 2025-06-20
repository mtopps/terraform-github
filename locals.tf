locals {
  common_plaintext_secrets = {
    gcp_workload_identity_provider_name = data.infisical_secrets.common_secrets.secrets.GCP_WIF_PROVIDER_ID.value
    gcp_workload_identity_sa_email      = data.infisical_secrets.common_secrets.secrets.GCP_WIF_SERVICE_ACCOUNT_ID.value
  }

  common_actions_variables = {
    "GCP_BUCKET" = data.infisical_secrets.common_secrets.secrets.GCE_BUCKET_NAME.value
  }

  plaintext_secrets = {
    for repo_key, repo in local.github_repositories :
    repo_key => merge(local.common_plaintext_secrets, try(repo.plaintext_secrets, {}))
  }

  actions_variables = {
    for repo_key, repo in local.github_repositories :
    repo_key => merge(local.common_actions_variables, try(repo.actions_variables, {}))
  }

  exclude_secrets = {
    for repo_key, repo in local.github_repositories :
    repo_key => try(repo.exclude_secrets, false)
  }

  common_rules = {
    allow_rebase_merge = true
  }

  merged_repositories = {
    for repo_key, repo in local.github_repositories :
    repo_key => merge(local.common_rules, repo)
  }

  non_sensitive_plaintext_secrets = {
    for repo_key, secret in local.plaintext_secrets :
    repo_key => {
      for k, v in secret :
      k => nonsensitive(v)
    }
  }

  non_sensitive_actions_variables = {
    for repo_key, secret in local.actions_variables :
    repo_key => {
      for k, v in secret :
      k => nonsensitive(v)
    }
  }
}
