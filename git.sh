#!/bin/bash
# 幂等

cd $(dirname $0)
if [[ "$UID" != 0 ]];then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

apt-get install git-all
if [[ $? != 0 ]];then
    mv /var/lib/dpkg/info /var/lib/dpkg/info_old
    mkdir /var/lib/dpkg/info
    apt-get update
    apt-get -f install
    mv /var/lib/dpkg/info/* /var/lib/dpkg/info_old/
    rm -rf /var/lib/dpkg/info
    mv /var/lib/dpkg/info_old /var/lib/dpkg/info

    apt-get install git-all
    if [[ $? != 0 ]];then
        echo -e "\033[1;31minstall git-all failed.\033[0m"
        exit 1
    fi
fi

git config --global user.name "Quan Chen"
git config --global user.email chenq182@sina.com
git config --global core.editor vim
git config --list

