# terraform-github
Terraform repo to manage Github repositories

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.5.0 |
| <a name="requirement_infisical"></a> [infisical](#requirement\_infisical) | 0.12.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_infisical"></a> [infisical](#provider\_infisical) | 0.12.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_github_repos"></a> [github\_repos](#module\_github\_repos) | git::https://github.com/mtopps/terraform-github-repositories.git | v0.0.1 |

## Resources

| Name | Type |
|------|------|
| [infisical_projects.main](https://registry.terraform.io/providers/Infisical/infisical/0.12.10/docs/data-sources/projects) | data source |
| [infisical_secrets.common_secrets](https://registry.terraform.io/providers/Infisical/infisical/0.12.10/docs/data-sources/secrets) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_infisical_client_id"></a> [infisical\_client\_id](#input\_infisical\_client\_id) | The client ID for the Infisical API | `string` | n/a | yes |
| <a name="input_infisical_client_secret"></a> [infisical\_client\_secret](#input\_infisical\_client\_secret) | The client secret for the Infisical API | `string` | n/a | yes |
| <a name="input_infisical_project_slug"></a> [infisical\_project\_slug](#input\_infisical\_project\_slug) | The slug of the Infisical project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repo_details"></a> [repo\_details](#output\_repo\_details) | Details of the GitHub repositories including their HTML URL and SSH clone URL. |
<!-- END_TF_DOCS -->