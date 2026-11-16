# A cheap/free GCP resource: an idle Pub/Sub topic sits in the always-free tier.
resource "google_pubsub_topic" "this" {
  project = var.project_id
  name    = var.topic_name
  labels  = var.labels
}

# Example provisioning step.
#
# This runs a LOCAL provisioning script after the topic is created. It is
# intentionally benign and transparent: it only writes a local marker file and
# prints a line. It makes no network calls, downloads nothing, and runs no
# remote code. See scripts/provision.sh.
resource "null_resource" "provision" {
  # Re-run the provisioner whenever the topic identity changes.
  triggers = {
    topic_id = google_pubsub_topic.this.id
  }

  provisioner "local-exec" {
    command     = "${path.module}/scripts/provision.sh"
    interpreter = ["/bin/bash", "-c"]

    environment = {
      TOPIC_NAME = google_pubsub_topic.this.name
      PROJECT_ID = var.project_id
    }
  }
}
