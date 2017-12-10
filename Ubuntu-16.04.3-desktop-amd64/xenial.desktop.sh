#!/bin/bash
# 幂等

cd $(dirname $0)
if [[ "$UID" != 0 ]]; then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

cp conf/xenial.sources.list /etc/apt/sources.list
apt-get update
apt-get upgrade
apt-get install vim
echo -e "set nu\nset noai nosi" > ~/.vimrc
sed -i 's/alF/lF/' ~/.bashrc

# l /var/cache/apt/archives/*.deb
