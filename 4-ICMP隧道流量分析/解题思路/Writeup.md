## 简介
题目说明：攻击者入侵内网主机后，使用 ICMP 隧道回传命令执行结果。参赛者需要从流量中还原攻击者在目标主机上执行的完整命令，并对该命令原文进行 MD5 计算，结果按 `flag{md5值}` 格式提交。

flag{5e40fd22931f112b3c2fdc17c8bc472a}

## 解题过程
打开 `icmp_tunnel.pcap` 后，先使用 `icmp` 过滤，可以看到除少量正常 ping 外，还存在一组异常的 Echo Request 和 Echo Reply。

进一步查看数据区，可以发现攻击机 `10.10.10.14` 发往受害机 `10.10.10.23` 的请求负载以 `cmd:` 开头，且内容是分片后的 Base64 数据；受害机返回的数据以 `res:` 开头，对应命令执行结果。

将请求方向的分片按序号拼接，可得到完整 Base64 字符串：

```text
YmFzaCAtYyAnY2F0IC9ldGMvcGFzc3dkIHwgZ3JlcCByb290Jw==
```

对其进行 Base64 解码，得到攻击者执行的完整命令：

```bash
bash -c 'cat /etc/passwd | grep root'
```

最后对上面的完整命令原文计算 MD5：

```bash
echo -n "bash -c 'cat /etc/passwd | grep root'" | md5sum
```

得到：

```text
5e40fd22931f112b3c2fdc17c8bc472a
```

因此最终答案为：

```text
flag{5e40fd22931f112b3c2fdc17c8bc472a}
```
