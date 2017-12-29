#!/bin/bash
# 幂等

cd $(dirname $0)
if [[ "$UID" != 0 ]]; then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

add-apt-repository -y ppa:hzwhuang/ss-qt5
apt-get update
apt-get -y install shadowsocks-qt5

apt-get -y install chromium-browser

curl https://get.docker.com > /tmp/install.docker.sh
bash /tmp/install.docker.sh
