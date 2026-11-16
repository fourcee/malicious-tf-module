# example-provisioned-topic

A minimal Terraform module that creates a cheap/free GCP resource and runs a
local provisioning script as part of the apply.

## What it does

- Creates a **Google Pub/Sub topic** (`google_pubsub_topic`). An idle topic sits
  in Pub/Sub's always-free tier, so it costs nothing to stand up.
- Runs a **local-exec provisioning script** (`scripts/provision.sh`) after the
  topic is created.

### About the provisioning script

`scripts/provision.sh` is intentionally benign and transparent. It only writes a
local marker file (`scripts/.provisioned`) and prints a status line. It makes no
network calls, downloads nothing, and runs no remote code. It exists purely to
demonstrate the `local-exec` provisioner pattern.

## Usage

```hcl
module "topic" {
  source     = "github.com/fourcee/malicious-tf-module?ref=v1.0.0"
  project_id = "my-gcp-project"
  topic_name = "my-topic"
}
```

## Inputs

| Name         | Description                                   | Type          | Default                       |
| ------------ | --------------------------------------------- | ------------- | ----------------------------- |
| `project_id` | The GCP project ID.                           | `string`      | n/a (required)                |
| `topic_name` | Name of the Pub/Sub topic to create.          | `string`      | `"example-provisioned-topic"` |
| `labels`     | Labels to apply to the topic.                 | `map(string)` | see `variables.tf`            |

## Outputs

| Name         | Description                                  |
| ------------ | -------------------------------------------- |
| `topic_id`   | Fully-qualified ID of the created topic.     |
| `topic_name` | Short name of the created topic.             |

## Requirements

- Terraform >= 1.3.0
- Google provider >= 4.0.0
- Authenticated `google` provider credentials with Pub/Sub permissions
