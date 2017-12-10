#!/bin/bash
# 幂等

PKG_FILE="apache-tomcat-9.0.1.tar.gz"
DES_PATH="/usr/share"
DES_NAME="tomcat9"

##################################################
# Ubuntu 16.04 specific settings
##################################################
InstallCFGs() {
    local f=${DES_PATH}/${DES_NAME}/conf/server.xml
    cp $f ${f}.bak.$(date +%Y%m%d%H%M)
    sed -i 's/8080/80/' $f
}

##################################################
# Script body
##################################################
cd $(dirname $0)
if [[ "$UID" != 0 ]];then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

PKG_NAME=${PKG_FILE%%.tar*}
if [ -f "${PKG_FILE}" ];then
    echo -e "\033[1;32m${PKG_FILE} exists.\033[0m"
else
    echo -e "\033[1;31m${PKG_FILE} doesn't exist.\033[0m"
    exit 1
fi

tar zxvf ${PKG_FILE} -C ${DES_PATH}/
rm -rf ${DES_PATH}/${DES_NAME}
mv ${DES_PATH}/${PKG_NAME} ${DES_PATH}/${DES_NAME}
echo -e "\033[1;32mInstall PKG done.\033[0m"

InstallCFGs
echo -e "\033[1mFINISHED.\033[0m"

