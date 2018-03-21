#!/bin/bash
rpm -qa|grep salt-minion
if [ $? -ne 0 ];then
  yum clean expire-cache
  yum install salt-minion -y
else
  ps -ef|grep salt-minion
  if [ $? -ne 0 ];then
  service salt-minion start
  fi
  echo "install already"
fi
sed -i 's/#master: salt/master: job.qk.com/g' /etc/salt/minion
service salt-minion restart
