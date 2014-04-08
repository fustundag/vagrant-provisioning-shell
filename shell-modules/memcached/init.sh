#! /bin/bash

yum install -y memcached
chkconfig memcached on
service memcached restart