#!/bin/sh

grep "experimental" /etc/apt/sources.list || {
    echo "deb http://httpredir.debian.org/debian experimental main contrib" >> /etc/apt/sources.list
}

apt update
apt install -t experimental tinc

mkdir -p /etc/tinc/librenet6/hosts

grep "librenet6" /etc/tinc/nets.boot || \
    echo librenet6 >> /etc/tinc/nets.boot

cat <<EOF >/etc/tinc/librenet6/tinc.conf
Name = gw_$(cat /etc/hostname)
Mode = switch
EOF

grep "0::0/0" /etc/babeld.conf || {
    echo "redistribute ip 0::0/0 le 0 allow" >> /etc/babeld.conf
}

[ -e /etc/tinc/librenet6/tinc-up ] || {
    cat <<EOF >/etc/tinc/librenet6/tinc-up
#!/bin/sh
ip -6 link set \$INTERFACE up txqueuelen 1000
babeld "$INTERFACE"
EOF
chmod +x /etc/tinc/librenet6/tinc-up
}

tinc -n librenet6 generate-keys < /dev/null
