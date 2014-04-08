#! /bin/bash

yum --enablerepo=remi install -y gearmand
chkconfig gearmand on
service gearmand restart