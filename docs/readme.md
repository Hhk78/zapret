```
while uci -q delete https-dns-proxy.@https-dns-proxy[0]; do :; done
uci set https-dns-proxy.dns="https-dns-proxy"
uci set https-dns-proxy.dns.bootstrap_dns="8.8.8.8,8.8.4.4"
uci set https-dns-proxy.dns.resolver_url="https://adblock.dns.mullvad.net/dns-query"
uci set https-dns-proxy.dns.listen_addr="127.0.0.1"
uci set https-dns-proxy.dns.listen_port="5053"
uci commit https-dns-proxy
service https-dns-proxy restart
```

```
opkg update
opkg install luci-app-https-dns-proxy
service rpcd restart
```

```
opkg update
opkg install https-dns-proxy
```
