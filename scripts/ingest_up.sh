#!/usr/bin/env bash
set -euo pipefail
CFG="config/namespace.yml"

yq_val(){ yq -r ".$1" "$CFG"; }
NS="$(yq_val name)"

[ $EUID -eq 0 ] || { echo "sudo required"; exit 1; }

# Start mosquitto as a transient unit *inside* the namespace
systemd-run --unit=gstyle-ingest --property=Restart=always \
  ip netns exec "$NS" /usr/sbin/mosquitto -c /run/gstyle/ingest/mosquitto.conf >/dev/null

echo "🚀 ingest: mosquitto running in ns:$NS (1883)"
