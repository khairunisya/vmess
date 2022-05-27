#!/bin/bash
# VStunnel
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
source /var/lib/crot/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -w "Trojan" | cut -d: -f2|sed 's/ //g')"
$1
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "2 days" +"%Y-%m-%d"`
sed -i '/#xray-trojan$/a\#&# '"$1 $exp"'\
},{"password": "'""$1""'","email": "'""$1""'"' /etc/xray/config.json
systemctl restart xray.service
trojanlink="trojan://$1@${domain}:${tr}"
service cron restart
clear
echo -e ""
echo -e "======-XRAYS/TROJAN-======"
echo -e "Remarks  : $1"
echo -e "IP/Host  : ${MYIP}"
echo -e "Address  : ${domain}"
echo -e "Port     : ${tr}"
echo -e "Key      : $1"
echo -e "Created  : $hariini"
echo -e "Expired  : $exp"
echo -e "=========================="
echo -e "Link TR  : ${trojanlink}"
echo -e "=========================="
echo -e "Script Mod By VStunnel"
