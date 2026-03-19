#!/bin/bash
set -euo pipefail

FLAG_PATH=/flag
DEFAULT_FLAG_CONTENT='flag{redis_ctf_fix_success}'
FLAG_CONTENT="${FLAG_CONTENT:-$DEFAULT_FLAG_CONTENT}"

while true; do
    auth_result="$(redis-cli --raw AUTH CTFpass 2>/dev/null || true)"
    ping_result="$(redis-cli --no-auth-warning -a CTFpass --raw PING 2>/dev/null || true)"

    if [[ "$auth_result" == "OK" && "$ping_result" == "PONG" ]]; then
        printf '%s\n' "$FLAG_CONTENT" > "$FLAG_PATH"
        chmod 644 "$FLAG_PATH"
        exit 0
    fi
    sleep 1
done
