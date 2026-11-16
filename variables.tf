variable "project_id" {
  description = "The GCP project ID in which to create resources."
  type        = string
}

variable "topic_name" {
  description = "Name of the Pub/Sub topic to create. Pub/Sub has a generous always-free tier, so an idle topic costs nothing."
  type        = string
  default     = "example-provisioned-topic"
}

variable "labels" {
  description = "Labels to apply to the Pub/Sub topic."
  type        = map(string)
  default = {
    managed-by = "terraform"
    module     = "example-provisioned-topic"
  }
}
