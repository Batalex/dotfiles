#!/usr/bin/env bash

mkdir -p /home/${USER}/certs
host_ip=$(ip route get 1.1.1.1 | awk '{print $7; exit}')

openssl genrsa -out /home/${USER}/certs/ca.key 2048
openssl req -x509 -new -nodes -key /home/${USER}/certs/ca.key -days 1024 -out /home/${USER}/certs/ca.crt -outform PEM -subj /C=US/ST=Denial/L=Springfield/O=Dis/CN=$host_ip
openssl genrsa -out /home/${USER}/certs/server.key
openssl req -new -key /home/${USER}/certs/server.key -out /home/${USER}/certs/server.csr -subj /C=US/ST=Denial/L=Springfield/O=Dis/CN=$host_ip
echo "subjectAltName = DNS:$host_ip, IP:$host_ip" > /home/${USER}/certs/extfile.cnf
openssl x509 -req -in /home/${USER}/certs/server.csr -CA /home/${USER}/certs/ca.crt -CAkey /home/${USER}/certs/ca.key -CAcreateserial -out /home/${USER}/certs/server.crt -days 365 -extfile /home/${USER}/certs/extfile.cnf

server_crt_base64=$(sudo base64 -w0 /home/${USER}/certs/server.crt)
server_key_base64=$(sudo base64 -w0 /home/${USER}/certs/server.key)
sudo microceph enable rgw --ssl-certificate $server_crt_base64 --ssl-private-key $server_key_base64
sudo microceph.radosgw-admin user create --uid test --display-name test --access-key=foo --secret-key=bar

