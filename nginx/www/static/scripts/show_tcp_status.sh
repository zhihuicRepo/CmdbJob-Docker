#!/bin/bash

all_tcp_status=$(/usr/sbin/ss -ant state all | awk '{++S[$1]} END {for (a in S) {printf "%11-s %s\n",a,S[a]}}')

echo "${all_tcp_status}"