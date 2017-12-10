#!/bin/bash
# 幂等

PKG_URL="http://mirror.bit.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz"
PKG_NAME="apache-maven-3.5.2"
DES_PATH="/usr/share"
DES_NAME="maven"

##################################################
# Ubuntu 16.04 specific settings
##################################################
InstallCFGs() {
    local f=${DES_PATH}/${DES_NAME}/conf/settings.xml
    cp $f ${f}.bak.$(date +%Y%m%d%H%M)
    sed -i '/^\s*<mirrors>\s*$/ r conf/maven.mirror.xml' $f
    ln -s ${DES_PATH}/${DES_NAME}/bin/mvn /usr/local/bin
}

##################################################
# Script body
##################################################
cd $(dirname $0)
if [[ "$UID" != 0 ]];then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

wget -c ${PKG_URL}
if [[ $? != 0 ]];then
    echo -e "\033[1;31mDownload PKG failed.\033[0m"
    exit 1
else
    echo -e "\033[1;32mDownload PKG done.\033[0m"
fi

PKG_FILE=${PKG_URL##*/}
tar zxvf ${PKG_FILE} -C ${DES_PATH}/
mv ${DES_PATH}/${PKG_NAME} ${DES_PATH}/${DES_NAME}
echo -e "\033[1;32mInstall PKG done.\033[0m"

InstallCFGs
echo -e "\033[1mFINISHED.\033[0m"

