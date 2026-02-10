#!/usr/bin/env bash
set -euo pipefail
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
python3 - <<'PY2'
print("Use assistant-managed sync to avoid drift in rules")
PY2

git -C "$REPO_DIR" add -A
if git -C "$REPO_DIR" diff --cached --quiet; then
  echo "No changes to commit"
  exit 0
fi

git -C "$REPO_DIR" commit -m "chore: backup sync $(date +'%Y-%m-%d %H:%M')"
git -C "$REPO_DIR" push origin main
