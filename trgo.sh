#!/bin/bash
# VSTUNNEL
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl ipinfo.io/ip | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Fuck You!!"
exit 0
fi
clear
uuid=$(cat /etc/trojan-go/uuid.txt)
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
trgo="$(cat ~/log-install.txt | grep -w "TrojanGo" | cut -d: -f2|sed 's/ //g')"
$1
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "2 days" +"%Y-%m-%d"`
sed -i '/"'""$uuid""'"$/a\,"'""$1""'"' /etc/trojan-go/config.json
echo -e "### $1 $exp" >> /etc/trojan-go/akun.conf
systemctl restart trojan-go.service
link="trojan-go://$1@${domain}:${trgo}/?sni=${domain}&type=ws&host=${domain}&path=/jrtunnel&encryption=none#$1"
clear
echo -e ""
echo -e "=======-TROJAN-GO-======="
echo -e "Remarks    : $1"
echo -e "IP/Host    : ${MYIP}"
echo -e "Address    : ${domain}"
echo -e "Port       : ${trgo}"
echo -e "Key        : $1"
echo -e "Encryption : none"
echo -e "Path       : /jrtunnel"
echo -e "Created    : $hariini"
echo -e "Expired    : $exp"
echo -e "========================="
echo -e "Link TrGo  : ${link}"
echo -e "========================="
echo -e "Script Mod By VStunnel"
