#!/usr/bin/env bash
#
# Benign example provisioning script for this Terraform module.
#
# Scope on purpose:
#   - No network access, no downloads, no `curl | sh`, no remote code.
#   - No reading of credentials, secrets, or environment beyond the two vars
#     Terraform passes in (TOPIC_NAME, PROJECT_ID).
#   - Side effect is limited to writing one marker file under the module dir.
#
# It exists only to demonstrate the local-exec provisioner pattern.

set -euo pipefail

TOPIC_NAME="${TOPIC_NAME:-unknown-topic}"
PROJECT_ID="${PROJECT_ID:-unknown-project}"

# Resolve the directory this script lives in so the marker lands beside it.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MARKER_FILE="${SCRIPT_DIR}/.provisioned"

echo "[provision] Provisioning complete for topic '${TOPIC_NAME}' in project '${PROJECT_ID}'."

cat > "${MARKER_FILE}" <<EOF
provisioned_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)
topic_name=${TOPIC_NAME}
project_id=${PROJECT_ID}
EOF

echo "[provision] Wrote marker file: ${MARKER_FILE}"
