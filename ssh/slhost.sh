#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
apt install jq curl -y
rm -rf /var/lib/crot/ipvps.conf
rm -f /root/domain
rm -f /etc/xray/domain
rm -rf /etc/xray/domain
mkdir -p /usr/bin/xray
mkdir -p /etc/xray

DOMAIN=dnsvstunnel.xyz
sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
SUB_DOMAIN=${sub}.dnsvstunnel.xyz
echo "IP=""$SUB_DOMAIN" >> /var/lib/crot/ipvps.conf
CF_ID=vstunnel@gmail.com
CF_KEY=bf2f943aba9cefaf4cc246ab198519ab15e93
set -euo pipefail
IP=$(wget -qO- icanhazip.com);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
rm -rf /etc/xray/domain
rm -rf /root/domain
echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /root/domain
echo "$SUB_DOMAIN" >> /etc/xray/domain
cp /root/domain /root/domain/
cp /root/domain /etc/xray/
cd
