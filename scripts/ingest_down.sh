#!/usr/bin/env bash
set -euo pipefail
[ $EUID -eq 0 ] || { echo "sudo required"; exit 1; }
systemctl stop gstyle-ingest 2>/dev/null || true
echo "🛑 ingest: stopped"
