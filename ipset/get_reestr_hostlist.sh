#!/bin/sh

IPSET_DIR="$(dirname "$0")"
IPSET_DIR="$(cd "$IPSET_DIR"; pwd)"

. "$IPSET_DIR/def.sh"

# useful in case ipban set is used in custom scripts
getuser
"$IPSET_DIR/create_ipset.sh"

ZREESTR="$TMPDIR/zapret.txt"
#ZURL=https://reestr.rublacklist.net/api/current
ZURL=https://raw.githubusercontent.com/zapret-info/z-i/master/dump.csv

curl -k --fail --max-time 600 --connect-timeout 5 --retry 3 --max-filesize 251658240 "$ZURL" >"$ZREESTR" ||
{
 echo reestr list download failed   
 exit 2
}
dlsize=$(LANG=C wc -c "$ZREESTR" | xargs | cut -f 1 -d ' ')
if test $dlsize -lt 204800; then
 echo list file is too small. can be bad.
 exit 2
fi
(LANG=C cut -s -f2 -d';' "$ZREESTR" | LANG=C sed -Ee 's/^\*\.(.+)$/\1/' -ne 's/^[a-z0-9A-Z._-]+$/&/p' | awk '{ print tolower($0) }' ; cat "$ZUSERLIST" ) | sort -u | zz "$ZHOSTLIST"
rm -f "$ZREESTR"

hup_zapret_daemons

exit 0
