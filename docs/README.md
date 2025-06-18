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
opkg install luci-app-https-dns-proxy https-dns-proxy
service rpcd restart
```
```bash
opkg update ; opkg install kmod-mt76-connac kmod-mt76-core kmod-mt7603 kmod-mt7615-common kmod-mt7615e kmod-mt7663-firmware-ap kmod-mt76x02-common kmod-mt76x2 kmod-mt76x2-common

```
