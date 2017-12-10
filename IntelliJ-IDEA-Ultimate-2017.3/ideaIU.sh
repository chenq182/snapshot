#!/bin/bash
# 幂等

cd $(dirname $0)
if [[ "$UID" != 0 ]]; then
    echo -e "\033[1;31mPlease use sudo.\033[0m"
    exit 1
fi

'''
../git.sh
../java.sh
../maven.sh
../mysql.sh
../tomcat.sh
'''

tar zxvf ../ideaIU-2017.3.tar.gz -C /usr/share/
mv /usr/share/idea-IU-173.3727.127 /usr/share/ideaIU
ln -s /usr/share/ideaIU/bin/idea.sh ~/
