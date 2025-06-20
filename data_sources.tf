data "infisical_projects" "main" {
  slug = var.infisical_project_slug
}

data "infisical_secrets" "common_secrets" {
  env_slug     = data.infisical_projects.main.environments.prod.slug
  workspace_id = data.infisical_projects.main.id
  folder_path  = "/"
}
