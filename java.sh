#!/bin/bash
# 幂等

PKG_FILE="jdk-8u152-linux-x64.tar.gz"
PKG_NAME="jdk1.8.0_152"
DES_PATH="/usr/share"
DES_NAME="java"

##################################################
# Ubuntu 16.04 specific settings
##################################################
InstallCFGs() {
    local f=/etc/profile.bak.$(date +%Y%m%d%H%M)
    cp /etc/profile $f
    sed -i '/# JAVA BEGIN #/{x;:a;N;/# JAVA END #/!ba;d}' /etc/profile
    echo "# JAVA BEGIN #" >>/etc/profile
    echo -e "export JAVA_HOME=${DES_PATH}/${DES_NAME}" >>/etc/profile
    echo "export JRE_HOME=\${JAVA_HOME}/jre" >>/etc/profile
    echo "# JAVA END #" >>/etc/profile
    ln -s ${DES_PATH}/${DES_NAME}/bin/java /usr/local/bin
    ln -s ${DES_PATH}/${DES_NAME}/bin/javac /usr/local/bin
    ln -s ${DES_PATH}/${DES_NAME}/bin/javah /usr/local/bin
}

##################################################
# Script body
##################################################
cd $(dirname $0)
if [[ "$UID" != 0 ]];then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

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
echo -e "\033[1mFINISHED.(Reboot needed.)\033[0m"

