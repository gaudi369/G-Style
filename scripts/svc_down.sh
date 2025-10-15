#!/usr/bin/env bash
set -euo pipefail
# Stop in reverse order when more stages exist
"$(dirname "$0")/ingest_down.sh"
