#!/bin/bash
#
# Detect if HTTP proxy server is reachable and if so, use it, otherwise
# pass the data through. Handy for VPN agnostic SSH client configuration:
#
# Host github.openssl.org
#  Hostname github.openssl.org
#  ProxyCommand ~/bin/proxy.sh %h %p
#
# Needs socat and OpenBSD or GNU Netcat.
#
# Note: does not work with the Netcat shipped with macOS.
#       Have to use GNU Netcat from Homebrew.
#

if (( $# != 2 )); then
	echo "usage: $0 host port"
	exit 1
fi

# TODO: remove
function check_vpn()
{
	ip link show vpn0 >/dev/null 2>&1
	if (( $? != 0 )); then
		vpn=0
	else
		ip link show vpn0 | grep NO-CARRIER >/dev/null
		if (( $? != 0 )); then
			vpn=1
		fi
	fi

	return vpn
}

# vpn = check_vpn()

use_proxy=0
# nc -w 1 -z -n $PROXY_IP $PROXY_PORT
# socat is faster than netcat because it allows sub-second connect timeout.
socat /dev/null TCP-CONNECT:$VPN_PROXY_IP:$VPN_PROXY_PORT,connect-timeout=0.1 2>/dev/null
if (( $? == 0 )); then
	use_proxy=1
fi

# TODO: replace netcat with socat
if (( use_proxy != 0 )); then
	# print "using proxy"
	exec nc -X connect -x $VPN_PROXY_IP:$VPN_PROXY_PORT $1 $2
else
	exec nc $1 $2
fi
