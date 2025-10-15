#!/usr/bin/env bash
set -euo pipefail
CFG="config/namespace.yml"

yq_val(){ yq -r ".$1" "$CFG"; }

NS="$(yq_val name)"
HOST_IF="$(yq_val host_if)"
NS_IF="$(yq_val ns_if)"
HOST_IP="$(yq_val host_ip_cidr)"
NS_IP="$(yq_val ns_ip_cidr)"

[ $EUID -eq 0 ] || { echo "sudo required"; exit 1; }

ip netns list | grep -qw "$NS" || ip netns add "$NS"

if ! ip link show "$HOST_IF" &>/dev/null; then
  ip link add "$HOST_IF" type veth peer name "$NS_IF"
fi

ip link set "$NS_IF" netns "$NS" 2>/dev/null || true

ip addr flush dev "$HOST_IF" || true
ip addr add "$HOST_IP" dev "$HOST_IF" || true
ip link set "$HOST_IF" up

ip netns exec "$NS" ip link set lo up
ip netns exec "$NS" ip addr flush dev "$NS_IF" || true
ip netns exec "$NS" ip addr add "$NS_IP" dev "$NS_IF" || true
ip netns exec "$NS" ip link set "$NS_IF" up

mkdir -p /run/gstyle/ingest
cp -a config/ingest/* /run/gstyle/ingest/

echo "✅ netns up: $NS  host=$HOST_IP  ns=$NS_IP"
