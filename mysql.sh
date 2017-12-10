#!/bin/bash
# 幂等

PKG_LIST=("mysql-server")

##################################################
# Ubuntu 16.04 specific settings
##################################################
InstallCFGs() {
    cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf
    sed -i '/\[mysqld\]/a\character_set_server=utf8\ncollation-server=utf8_general_ci' \
        /etc/mysql/my.cnf
    sed -i 's/^.*bind-address/# bind-address/g' /etc/mysql/my.cnf
    service mysql restart
}

##################################################
# Script body
##################################################
cd $(dirname $0)
if [[ "$UID" != 0 ]];then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

apt-get install ${PKG_LIST[@]}
if [[ $? != 0 ]];then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    exit 1
else
    echo -e "\033[1;32mInstallation done.\033[0m"
fi

InstallCFGs
echo -e "\033[1mFINISHED.\033[0m"

