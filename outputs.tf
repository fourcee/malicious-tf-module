output "topic_id" {
  description = "The fully-qualified ID of the created Pub/Sub topic."
  value       = google_pubsub_topic.this.id
}

output "topic_name" {
  description = "The short name of the created Pub/Sub topic."
  value       = google_pubsub_topic.this.name
}
