terraform {
  required_version = ">= 1.11.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.5.0"
    }
    infisical = {
      source  = "Infisical/infisical"
      version = "0.12.10"
    }
  }
}

provider "github" {
  token = data.infisical_secrets.common_secrets.secrets.GITHUB_API_TOKEN.value
}

provider "infisical" {
  client_id     = var.infisical_client_id
  client_secret = var.infisical_client_secret
}
