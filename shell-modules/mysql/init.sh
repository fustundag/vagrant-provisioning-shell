#! /bin/bash

yum install -y mysql-server mysql-devel
service mysqld stop

rm -f /etc/my.cnf

if [[ -z "$MYSQL_CONF_FILE" ]]
then
    cp -f "${SHELL_SCRIPT_MODULE_PATH}/mysql/files/my.cnf" /etc/my.cnf
else
    cp -f "$MYSQL_CONF_FILE" /etc/my.cnf
fi

chkconfig mysqld on
service mysqld start

mysql -u root -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '' WITH GRANT OPTION;"

if [[ ! -z "$MYSQL_SQL_FILE" ]]
then
    mysql -u root < "$MYSQL_SQL_FILE"
fi