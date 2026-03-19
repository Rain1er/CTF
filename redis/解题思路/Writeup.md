## 简介

题目说明：本题开放 `7681` 端口提供在线 bash 终端。参赛者需要在终端中修复 Redis 配置，使其启用密码 `CTFpass`。修复成功后，容器根目录会生成 `/flag`。

flag{redis_ctf_fix_success}

## 解题过程

进入在线终端后，先确认 Redis 当前无需认证：

```bash
redis-cli PING
```

如果直接返回 `PONG`，说明当前未启用密码。

随后执行修复：

```bash
redis-cli CONFIG SET requirepass CTFpass
redis-cli -a CTFpass PING
cat /flag
```

当 `redis-cli -a CTFpass PING` 返回 `PONG` 后，后台 root 权限的检查脚本会写出 `/flag`。
