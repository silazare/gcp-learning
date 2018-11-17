terraform {
  backend "gcs" {
    bucket = "tf-state-structured"
    prefix = "terraform/gitlab_state"
  }
}
