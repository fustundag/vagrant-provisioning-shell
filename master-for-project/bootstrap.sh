#! /bin/bash

set -u
export SHELL_SCRIPT_MODULE_PATH="/vagrant/vagrant/modules"
###export HTTPD_VHOST_FILE="/vagrant/vagrant/httpd-vhost.conf"
###export MYSQL_CONF_FILE="/vagrant/vagrant/my.cnf"
###export MYSQL_SQL_FILE="/vagrant/vagrant/db.sql"
###export NGINX_VHOST_FILE="/vagrant/vagrant/nginx-vhost.conf"
###export PHP_MODULES=""
###export PHPFPM_CONF_FILE="/vagrant/vagrant/php-fpm.conf"
###export PHP_INI_FILE="/vagrant/vagrant/php-development.ini"
export PHP_RUN_COMPOSER="ON"
###export XDEBUG_REMOTE_DEBUGGING="ON"
###export XDEBUG_REMOTE_INI_FILE="/vagrant/vagrant/xdebug-remote.ini"
###export XDEBUG_PROFILER="ON"
###export XDEBUG_PROFILER_INI_FILE="/vagrant/vagrant/xdebug-profiler.ini"

source "${SHELL_SCRIPT_MODULE_PATH}/lib.sh"

runModules "base" "remi" "php54" "httpd"