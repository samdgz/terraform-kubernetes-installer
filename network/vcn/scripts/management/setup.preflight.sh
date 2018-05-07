#!/bin/bash -x

EXTERNAL_IP=$(curl -s -m 10 http://whatismyip.akamai.com/)

bash -x /root/setup.sh | tee -a /root/setup.log
