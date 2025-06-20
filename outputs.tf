output "repo_details" {
  description = "Details of the GitHub repositories including their HTML URL and SSH clone URL."
  value = {
    for k, v in module.github_repos : k => {
      repo_url      = v.html_url
      ssh_clone_url = "git clone ${v.ssh_clone_url}"
    }
  }
}
