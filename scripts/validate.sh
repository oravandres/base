#!/usr/bin/env bash
set -euo pipefail

fail() { echo "❌ $1"; exit 1; }

# Check env
[ -f .env ] || echo "⚠️  .env not found. Copy .env.example to .env and configure values."

# Check Ansible
command -v ansible >/dev/null || fail "Ansible is not installed. Install with: pip install ansible"

# Check collections baseline
ansible-galaxy collection list | grep -q kubernetes.core || echo "ℹ️  Install kubernetes.core: ansible-galaxy collection install kubernetes.core"

# Validate inventory syntax if provided
INV=${1:-ansible/inventory/production/hosts.yaml}
[ -f "$INV" ] || fail "Inventory file not found: $INV"
ansible-inventory -i "$INV" --graph | cat

echo "✅ Validation checks passed"
