#! /bin/bash

if [[ -z "$PHP_MODULES" ]]
then
    yum --enablerepo=remi install -y php php-pear php-pecl-xdebug php-pecl-xhprof php-mysql php-pecl-mongo php-redis php-pecl-memcached php-xml php-gd php-mbstring php-mcrypt php-fpm php-gearman php-soap
else
    yum --enablerepo=remi install -y php php-pear php-pecl-xdebug php-pecl-xhprof php-mysql php-pecl-mongo php-redis php-pecl-memcached php-xml php-gd php-mbstring php-mcrypt php-fpm php-gearman php-soap $PHP_MODULES
fi

if [ ! -f /usr/local/bin/composer ]
then
	curl -sS https://getcomposer.org/installer | php
	mv composer.phar /usr/local/bin/composer
fi

rm -f /etc/php-fpm.d/www.conf
rm -f /etc/php.d/php-development.ini

if [[ -z "$PHPFPM_CONF_FILE" ]]
then
    cp "${SHELL_SCRIPT_MODULE_PATH}/php54/files/www.conf" /etc/php-fpm.d/www.conf
else
    cp "${PHPFPM_CONF_FILE}" /etc/php-fpm.d/www.conf
fi

if [[ -z "$PHP_INI_FILE" ]]
then
    cp "${SHELL_SCRIPT_MODULE_PATH}/php54/files/php-development.ini" /etc/php.d/php-development.ini
else
    cp "${PHP_INI_FILE}" /etc/php.d/php-development.ini
fi

rm -f /etc/php.d/xdebug-remote.ini
if [[ ! -z "$XDEBUG_REMOTE_DEBUGGING" ]]
then
    if [[ -z "$XDEBUG_REMOTE_INI_FILE" ]]
    then
        cp "${SHELL_SCRIPT_MODULE_PATH}/php54/files/xdebug-remote.ini" /etc/php.d/xdebug-remote.ini
    else
        cp "${XDEBUG_REMOTE_INI_FILE}" /etc/php.d/xdebug-remote.ini
    fi
fi

rm -f /etc/php.d/xdebug-profiler.ini
if [[ ! -z "$XDEBUG_PROFILER" ]]
then
    if [[ -z "$XDEBUG_PROFILER_INI_FILE" ]]
    then
        cp "${SHELL_SCRIPT_MODULE_PATH}/php54/files/xdebug-profiler.ini" /etc/php.d/xdebug-profiler.ini
    else
        cp "${XDEBUG_PROFILER_INI_FILE}" /etc/php.d/xdebug-profiler.ini
    fi
fi

if [[ ! -z "$PHP_RUN_COMPOSER" ]]
then
    rm -f /vagrant/composer.lock
    /usr/local/bin/composer self-update
    /usr/local/bin/composer -d=/vagrant install
    if [ -d "/vagrant/vendor/bin" ]; then
        echo 'pathmunge /vagrant/vendor/bin' > /etc/profile.d/phpcomposer_vendor.sh
        chmod +x /etc/profile.d/phpcomposer_vendor.sh
        . /etc/profile
    fi
fi

if [[ ! -z "$PHP_INSTALL_PHALCON" ]]
then
    git clone --depth=1 git://github.com/phalcon/cphalcon.git
    cd cphalcon/build
    ./install
    touch /etc/php.d/phalcon.ini
    echo "extension=phalcon.so" > /etc/php.d/phalcon.ini
    service php-fpm restart
fi

chkconfig php-fpm on
service php-fpm restart