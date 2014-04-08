#! /bin/bash

rpm -qa | grep -q httpd || yum --enablerepo=remi install -y httpd

rm -f /etc/httpd/conf.d/vhost.conf
rm -f /etc/httpd/conf.d/welcome.conf
rm -f /etc/httpd/conf.d/pinfo.conf

if [[ -z "$HTTPD_VHOST_FILE" ]]
then
    ln -s "${SHELL_SCRIPT_MODULE_PATH}/httpd/files/vhost.conf" /etc/httpd/conf.d/vhost.conf
else
    ln -s "${HTTPD_VHOST_FILE}" /etc/httpd/conf.d/vhost.conf
fi

ln -s "${SHELL_SCRIPT_MODULE_PATH}/httpd/files/pinfo.conf" /etc/httpd/conf.d/pinfo.conf

chkconfig httpd on
service httpd restart