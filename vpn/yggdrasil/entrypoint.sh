#!/bin/sh
sysctl net.ipv6.conf.all.disable_ipv6=0 || true
if [ -e /config/yggdrasil.conf ]
then
        /yggdrasil -useconffile /config/yggdrasil.conf
else
        /yggdrasil -genconf > /config/yggdrasil.conf
        /yggdrasil -useconffile /config/yggdrasil.conf
fi
