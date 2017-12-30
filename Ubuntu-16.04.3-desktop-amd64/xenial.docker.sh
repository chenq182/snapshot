#!/bin/bash
# 幂等

cd $(dirname $0)
if [[ "$UID" != 0 ]]; then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

timedatectl set-local-rtc 1

add-apt-repository -y ppa:hzwhuang/ss-qt5
apt-get update
apt-get -y purge aisleriot
apt-get -y purge gnome-sudoku
apt-get -y purge gnome-mahjongg
apt-get -y purge gnome-mines
apt-get -y purge libreoffice*
apt-get -y purge thunderbird*
apt-get -y purge webbrowser-app
# apt-get upgrade
# l /var/cache/apt/archives/*.deb
apt-get install vim
echo -e "set nu\nset noai nosi" > ~/.vimrc
sed -i 's/alF/lF/' ~/.bashrc

apt-get -y install shadowsocks-qt5
# 45.77.191.57
# AES-256-CFB

apt-get -y install chromium-browser
# chromium-browser --proxy-server="socks5://127.0.0.1:1080"
# <proxy switchyomega>
# https://github.com/gfwlist/gfwlist
# https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
# <office online>

apt-get -y install curl
curl https://get.docker.com > install.docker.sh
bash install.docker.sh
rm install.docker.sh
systemctl start docker.service
systemctl enable docker.service
