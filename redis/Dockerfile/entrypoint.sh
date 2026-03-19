#!/bin/bash
set -euo pipefail

rm -f /flag
/check.sh &
su ctf -c "/usr/bin/ttyd -p 7681 -W /bin/bash" &
su ctf -c "/usr/bin/redis-server /home/ctf/redis.conf" &

exec tail -f /dev/null
