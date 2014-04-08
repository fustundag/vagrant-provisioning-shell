#! /bin/bash

rm -f /etc/yum.repos.d/mongodb.repo

echo """[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64/
gpgcheck=0
enabled=1""" >> /etc/yum.repos.d/mongodb.repo

yum install -y mongo10-gen
yum install -y mongo-10gen-server
chkconfig mongod on
service mongod restart