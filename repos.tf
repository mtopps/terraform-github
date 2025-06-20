locals {
  github_repositories = {
    "terraform-github" = {
      description            = "Terraform repo to manage Github repositories"
      visibility             = "public"
      topics                 = ["terraform", "github"]
      auto_init              = true
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      actions_variables = {
        "GCP_BUCKET_PREFIX" = data.infisical_secrets.common_secrets.secrets.GCE_GITHUB_TERRAFORM_STATE_PATH.value
      }
    }
    "terraform-github-repositories" = {
      description            = "Terraform module to provision Github repositories"
      visibility             = "public"
      topics                 = ["terraform", "github"]
      auto_init              = true
      has_issues             = false
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      allow_rebase_merge     = false
      exclude_secrets        = true
    }
    "terraform-gcp-org" = {
      description            = "Terraform repo to manage GCP Organization"
      topics                 = ["terraform", "gcp"]
      auto_init              = true
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      actions_variables = {
        "GCP_BUCKET_PREFIX" = data.infisical_secrets.common_secrets.secrets.GCE_ORG_TERRAFORM_STATE_PATH.value
        "billing_account"   = data.infisical_secrets.common_secrets.secrets.GCP_BILLING_ACCOUNT_ID.value
        "org_id"            = data.infisical_secrets.common_secrets.secrets.GCP_ORG_ID.value
      }
    }
    "terraform-gcp-workforce-identity-federation" = {
      description            = "Terraform repo to manage GCP Workforce Identity Federation"
      topics                 = ["github", "terraform"]
      gitignore_template     = "Terraform"
      auto_init              = true
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      actions_variables = {
        "GCP_BUCKET_PREFIX" = data.infisical_secrets.common_secrets.secrets.GCE_WIF_TERRAFORM_STATE_PATH.value
      }
    }
    "github-workflows" = {
      description            = "Repo to store workflow templates"
      topics                 = ["github", "workflows"]
      auto_init              = true
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      actions_variables      = {}
      exclude_secrets        = true
    }
    "terraform-gcp-network" = {
      description            = "Terraform repo to manage GCP Networks"
      topics                 = ["terraform", "gcp"]
      auto_init              = true
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      actions_variables = {
        "GCP_BUCKET_PREFIX" = data.infisical_secrets.common_secrets.secrets.GCE_NETWORKS_TERRAFORM_STATE_PATH.value
      }
    }
    "terraform-cloudflare" = {
      description            = "Terraform repo to manage Cloudflare resources"
      topics                 = ["terraform", "cloudflare"]
      auto_init              = true
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      actions_variables = {
        "GCP_BUCKET_PREFIX" = data.infisical_secrets.common_secrets.secrets.GCE_CLOUDFLARE_TERRAFORM_STATE_PATH.value
      }
    }
    "terraform-templates" = {
      description            = "Terraform template repository"
      topics                 = ["terraform", "github"]
      auto_init              = true
      has_issues             = true
      has_projects           = true
      is_template            = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      action_variables       = {}
      exclude_secrets        = true
    }
    "docker-compose" = {
      description            = "Docker compose repository"
      topics                 = ["docker", "compose"]
      auto_init              = false
      has_issues             = true
      has_projects           = true
      vulnerability_alerts   = true
      delete_branch_on_merge = true
      exclude_secrets        = true
      actions_variables      = {}
    }
  }
}


module "github_repos" {
  source   = "git::https://github.com/mtopps/terraform-github-repositories.git?ref=v0.0.1"
  for_each = local.merged_repositories

  name                   = try(each.key, "")
  description            = try(each.value.description, "")
  visibility             = try(each.value.visibility, "private")
  topics                 = try(each.value.topics, [])
  gitignore_template     = try(each.value.gitignore_template, null)
  auto_init              = try(each.value.auto_init, false)
  archived               = try(each.value.archived, false)
  has_issues             = try(each.value.has_issues, false)
  has_projects           = try(each.value.has_projects, false)
  license_template       = try(each.value.license_template, null)
  vulnerability_alerts   = try(each.value.vulnerability_alerts, false)
  delete_branch_on_merge = try(each.value.delete_branch_on_merge, false)
  is_template            = try(each.value.is_template, false)
  allow_rebase_merge     = try(each.value.allow_rebase_merge, false)
  template               = try(each.value.template, null)
  pages                  = try(each.value.pages, null)

  plaintext_secrets = local.exclude_secrets[each.key] ? null : local.non_sensitive_plaintext_secrets[each.key]
  actions_variables = local.exclude_secrets[each.key] ? null : local.non_sensitive_actions_variables[each.key]
}
