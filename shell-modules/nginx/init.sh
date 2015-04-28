#! /bin/bash

yum --enablerepo=remi install -y nginx

rm -f /etc/nginx/conf.d/default.conf
rm -f /etc/nginx/conf.d/virtual.conf
rm -f /etc/nginx/conf.d/vhost.conf

if [[ -z "$NGINX_VHOST_FILE" ]]
then
    cp "${SHELL_SCRIPT_MODULE_PATH}/nginx/files/vhost.conf" /etc/nginx/conf.d/vhost.conf
else
    cp "${NGINX_VHOST_FILE}" /etc/nginx/conf.d/vhost.conf
fi

chkconfig nginx on
service nginx restart