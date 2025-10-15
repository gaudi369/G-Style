#!/usr/bin/env bash
set -euo pipefail
# Future: add other stages here (process/store/render)
"$(dirname "$0")/ingest_up.sh"
