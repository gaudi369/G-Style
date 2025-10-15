#!/usr/bin/env bash
set -euo pipefail
CFG="config/namespace.yml"

yq_val(){ yq -r ".$1" "$CFG"; }

NS="$(yq_val name)"
HOST_IF="$(yq_val host_if)"

[ $EUID -eq 0 ] || { echo "sudo required"; exit 1; }

# kill any remaining processes in the namespace (safety)
for pid in $(ip netns pids "$NS" 2>/dev/null || true); do
  kill -9 "$pid" 2>/dev/null || true
done

ip link del "$HOST_IF" 2>/dev/null || true
ip netns del "$NS" 2>/dev/null || true
rm -rf /run/gstyle 2>/dev/null || true

echo "🧹 netns down: $NS; /run/gstyle wiped"
