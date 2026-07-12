#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$ROOT_DIR/set-env.sh" ]; then
  # shellcheck source=/dev/null
  . "$ROOT_DIR/set-env.sh"
fi

cd "$SCRIPT_DIR"
exec dbt "$@" --profiles-dir "$ROOT_DIR"
