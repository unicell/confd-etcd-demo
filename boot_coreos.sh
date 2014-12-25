#!/bin/bash

if [ -n "$1" ]; then
    DROPLET_NAME=$1
else
    DROPLET_NAME=tcore00
fi

curl -X POST "https://api.digitalocean.com/v2/droplets" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer $DO_TOKEN" \
     -d'{"name":"'"$DROPLET_NAME"'",
         "region":"nyc3",
         "image":"coreos-stable",
         "size":"512mb",
         "private_networking":true,
         "ssh_keys":[603313],
         "user_data":
"#cloud-config

coreos:
  etcd:
    # generate a new token for each unique cluster from https://discovery.etcd.io/new
    discovery: '"$DISCOVERY_URL"'
    # use $public_ipv4 if your datacenter of choice does not support private networking
    addr: $private_ipv4:4001
    peer-addr: $private_ipv4:7001
  fleet:
    public-ip: $private_ipv4        # used for fleetctl ssh command
    metadata: region=nyc3,public_ip=$public_ipv4
  units:
    - name: etcd.service
      command: start
    - name: fleet.service
      command: start"}'
