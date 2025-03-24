#!/bin/bash
#
# Detect if HTTP proxy server is reachable and if so, use it, otherwise
# pass the data through. Handy for VPN agnostic SSH client configuration:
#
# Host github.openssl.org
#  Hostname github.openssl.org
#  ProxyCommand ~/bin/proxy.sh %h %p
#
# Requires socat.
#

if (( $# != 2 )); then
	echo "usage: $0 host port"
	exit 1
fi

socat=$( which socat )
if [[ -z $socat ]]; then
	echo "Install socat first"
	exit 1
fi

use_proxy=0
#
# socat is faster in detecting whether proxy is responding than netcat
# because it allows sub-second connect timeout.
#
socat /dev/null TCP-CONNECT:$VPN_PROXY_IP:$VPN_PROXY_PORT,connect-timeout=0.1 2>/dev/null
if (( $? == 0 )); then
	exec socat - PROXY:$VPN_PROXY_IP:$1:$2,proxyport=$VPN_PROXY_PORT
else
	exec nc $1 $2
fi
