#!/usr/bin/env bash
set -euo pipefail

# Pre-flight
if [ ! -f .env ]; then
  echo "❌ .env not found. Copy .env.example to .env and configure your values."
  exit 1
fi

# Load env
set -a
. ./.env
set +a

# Dependencies
if ! command -v ansible >/dev/null; then
  echo "Installing Ansible..."
  pip install --user ansible >/dev/null
fi

# Collections
ansible-galaxy collection install kubernetes.core community.docker >/dev/null

# Run
ANSIBLE_INVENTORY=${ANSIBLE_INVENTORY:-ansible/inventory/production/hosts.yaml}
PLAYBOOK=${PLAYBOOK:-ansible/playbooks/site.yaml}

ansible-playbook -i "$ANSIBLE_INVENTORY" "$PLAYBOOK" --extra-vars "tailscale_auth_key=${TAILSCALE_AUTH_KEY:-}" | cat
