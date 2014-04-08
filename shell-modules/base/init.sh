#! /bin/bash

sed -i "s|enabled=1|enabled=0|" /etc/yum/pluginconf.d/fastestmirror.conf
/etc/init.d/iptables stop
chkconfig iptables off

rm -f /etc/profile.d/vagrant.sh
cp -f "${SHELL_SCRIPT_MODULE_PATH}/base/files/vagrant.sh" /etc/profile.d/vagrant.sh
chmod 755 /etc/profile.d/vagrant.sh

yum install -y git-core