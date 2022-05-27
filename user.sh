#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
# Load params
source /etc/wireguard/params
source /var/lib/premium-script/ipvps.conf
if [[ "$IP" = "" ]]; then
SERVER_PUB_IP=$(curl -s https://checkip.amazonaws.com/);
domain="$(cat /home/domain)"
else
SERVER_PUB_IP=$IP
fi
	echo ""
	$1

	echo "IPv4 Detected"
	ENDPOINT="bug.com.sg1wg.ipservers.us:$SERVER_PORT"
	WG_CONFIG="/etc/wireguard/wg0.conf"
	LASTIP=$( grep "/32" $WG_CONFIG | tail -n1 | awk '{print $3}' | cut -d "/" -f 1 | cut -d "." -f 4 )
	if [[ "$LASTIP" = "" ]]; then
	CLIENT_ADDRESS="10.66.66.2"
	else
	CLIENT_ADDRESS="10.66.66.$((LASTIP+1))"
	fi

	# Adguard DNS by default
	CLIENT_DNS_1="8.8.8.8"

	CLIENT_DNS_2="8.8.4.4"
	MYIP=$(curl -s https://checkip.amazonaws.com/);
	read -p "Expired (days): " 2
	exp=`date -d "2 days" +"%Y-%m-%d"`

	# Generate key pair for the client
	CLIENT_PRIV_KEY=$(wg genkey)
	CLIENT_PUB_KEY=$(echo "$CLIENT_PRIV_KEY" | wg pubkey)
	CLIENT_PRE_SHARED_KEY=$(wg genpsk)

	# Create client file and add the server as a peer
	echo "[Interface]
PrivateKey = $CLIENT_PRIV_KEY
Address = $CLIENT_ADDRESS/24
DNS = $CLIENT_DNS_1,$CLIENT_DNS_2

[Peer]
PublicKey = $SERVER_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
Endpoint = $ENDPOINT
AllowedIPs = 0.0.0.0/0,::/0" >>"$HOME/$SERVER_WG_NIC-client-$1.conf"

	# Add the client as a peer to the server
	echo -e "### Client $1 $exp
[Peer]
PublicKey = $CLIENT_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
AllowedIPs = $CLIENT_ADDRESS/32" >>"/etc/wireguard/$SERVER_WG_NIC.conf"
	systemctl restart "wg-quick@$SERVER_WG_NIC"
	cp $HOME/$SERVER_WG_NIC-client-$1.conf /home/vps/public_html/$1.conf
	clear
	sleep 0.5
	echo Generate PrivateKey
	sleep 0.5
	echo Generate PublicKey
	sleep 0.5
	echo Generate PresharedKey
	clear
	echo -e ""
	echo -e "==========-Wireguard-=========="
	echo -e "Wireguard	: http://$MYIP/$1.conf"
	echo -e "==============================="
	echo -e "Expired On      : $exp"
	rm -f /root/wg0-client-$1.conf