#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
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
# Link Hosting Kalian Untuk Ssh Vpn
akbarvpn="premium.vstunnel.com/main/ssh"
# Link Hosting Kalian Untuk Sstp
akbarvpnn="premium.vstunnel.com/main/sstp"
# Link Hosting Kalian Untuk Ssr
akbarvpnnn="premium.vstunnel.com/main/ssr"
# Link Hosting Kalian Untuk Shadowsocks
akbarvpnnnn="premium.vstunnel.com/main/shadowsocks"
# Link Hosting Kalian Untuk Wireguard
akbarvpnnnnn="premium.vstunnel.com/main/wireguard"
# Link Hosting Kalian Untuk Xray
akbarvpnnnnnn="premium.vstunnel.com/main/xray"
# Link Hosting Kalian Untuk Ipsec
akbarvpnnnnnnn="premium.vstunnel.com/main/ipsec"
# Link Hosting Kalian Untuk Backup
akbarvpnnnnnnnn="premium.vstunnel.com/main/backup"
# Link Hosting Kalian Untuk Websocket
akbarvpnnnnnnnnn="premium.vstunnel.com/main/websocket"
# Link Hosting Kalian Untuk Ohp
akbarvpnnnnnnnnnn="premium.vstunnel.com/main/ohp"

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(wget -qO- ipinfo.io/ip);

rm -f setup.sh
clear
if [ -f "/etc/xray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /var/lib/crot;
echo "IP=" >> /var/lib/crot/ipvps.conf
#install Domain
wget http://${akbarvpn}/slhost.sh && chmod +x slhost.sh && ./slhost.sh
#install xray
wget http://${akbarvpnnnnnn}/ins-xray.sh && chmod +x ins-xray.sh && screen -S xray ./ins-xray.sh
#install ssh ovpn
wget http://${akbarvpn}/ssh-vpn.sh && chmod +x ssh-vpn.sh && screen -S ssh-vpn ./ssh-vpn.sh
#wget http://${akbarvpnn}/sstp.sh && chmod +x sstp.sh && screen -S sstp ./sstp.sh
#install ssr
#wget http://${akbarvpnnn}/ssr.sh && chmod +x ssr.sh && screen -S ssr ./ssr.sh
#wget http://${akbarvpnnnn}/sodosok.sh && chmod +x sodosok.sh && screen -S ss ./sodosok.sh
#installwg
wget http://${akbarvpnnnnn}/wg.sh && chmod +x wg.sh && screen -S wg ./wg.sh
#install L2TP
#wget http://${akbarvpnnnnnnn}/ipsec.sh && chmod +x ipsec.sh && screen -S ipsec ./ipsec.sh
#wget http://${akbarvpnnnnnnnn}/set-br.sh && chmod +x set-br.sh && ./set-br.sh
# Websocket
#wget http://${akbarvpnnnnnnnnn}/edu.sh && chmod +x edu.sh && ./edu.sh
# Ohp Server
#wget http://${akbarvpnnnnnnnnnn}/ohp.sh && chmod +x ohp.sh && ./ohp.sh
# Install Slowdns Server
# wget https://raw.githubusercontent.com/fisabiliyusri/Mantap/main/Slowdns/install && chmod +x install && bash install
# Informasi IP Saya dan Semua Port TCP UDP
# wget https://raw.githubusercontent.com/fisabiliyusri/Mantap/main/ipsaya.sh && chmod +x ipsaya.sh
#
# install xray grpc
wget http://premium.vstunnel.com/main/grpc/sl-grpc.sh && chmod +x sl-grpc.sh && sed -i -e 's/\r$//' sl-grpc.sh && screen -S sl-grpc ./sl-grpc.sh
# install shadowsocks plugin
#wget http://premium.vstunnel.com/main/shadowsocks/install-ss-plugin.sh && chmod +x install-ss-plugin.sh && ./install-ss-plugin.sh
#

rm -f /root/ssh-vpn.sh
#rm -f /root/sstp.sh
rm -f /root/wg.sh
#rm -f /root/ss.sh
#rm -f /root/ssr.sh
rm -f /root/ins-xray.sh
#rm -f /root/ipsec.sh
#rm -f /root/set-br.sh
#rm -f /root/edu.sh
#rm -f /root/ohp.sh
rm -f /root/install
rm -f /root/sl-grpc.sh
rm -f /root/install-ss-plugin.sh
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=nekopoi.care

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget -O /etc/set.sh "http://${akbarvpn}/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver
echo " "
echo "Installation has been completed!!"echo " "
echo "============================================================================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22, 2253"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Wireguard               : 7070"  | tee -a log-install.txt
echo "   - L2TP/IPSEC VPN          : 1701"  | tee -a log-install.txt
echo "   - PPTP VPN                : 1732"  | tee -a log-install.txt
echo "   - SSTP VPN                : 444"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 8443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 8880"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2443"  | tee -a log-install.txt
echo "   - XRAYS VMESS GRPC        : 1180"  | tee -a log-install.txt
echo "   - XRAYS VLESS GRPC        : 2280"  | tee -a log-install.txt
echo "   - CloudFront Websocket    : "  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 880"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - TrojanGo                : 1443"  | tee -a log-install.txt
echo "   - SLOWDNS OpenSSH         : 2253[OFF]"  | tee -a log-install.txt
echo "   - SLOWDNS Dropbear        : 1153[OFF]"  | tee -a log-install.txt
echo "   - SLOWDNS SSL/TLS         : 3353[OFF]"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo " Reboot 15 Sec"
sleep 15
rm -f setup.sh
reboot
