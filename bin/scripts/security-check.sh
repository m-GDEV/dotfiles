#!/bin/bash


# This script sends a ping to my uptime kuma instance to verify its online and sends its public ip address

while [ 6 -gt 5 ]; do
    PUBLIC_IP=$(curl -s ifconfig.me)
    curl -s "https://status.vps.connectwithmusa.com/api/push/XkaXFxTyQw?status=up&msg=$PUBLIC_IP&ping="
    sleep 30
done
