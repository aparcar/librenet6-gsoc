#!/bin/sh
  
HOSTNAME="$(uci get system.@system[0].hostname)"

# add tinc configuration
[[ -e /etc/tinc/librenet6/tinc.conf ]] || {
    mkdir -p /etc/tinc/librenet6/hosts/
    cat <<EOF >/etc/tinc/librenet6/tinc.conf
    Name = node_$HOSTNAME
    Mode = switch
    ConnectTo = topu
EOF
}

