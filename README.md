This repo includes automation scripts for Digital Ocean's tutorial on
[How To Use Confd and Etcd to Dynamically Reconfigure Services in
CoreOS](https://www.digitalocean.com/community/tutorials/how-to-use-confd-and-etcd-to-dynamically-reconfigure-services-in-coreos)

# Quick Start 

## image build

Existing images of unicell/confd-etcd-demo-web and
unicell/confd-etcd-demo-nginx-lb can be found in Docker Hub Registry. If to
build ones own, please be sure to update references inside
templates/apache@.service and static/nginx-lb.service.

    $ docker build -t unicell/confd-etcd-demo-web docker-web
    $ docker push unicell/confd-etcd-demo-web
    $ docker build -t unicell/confd-etcd-demo-nginx-lb docker-nginx-lb
    $ docker push unicell/confd-etcd-demo-nginx-lb

## CoreOS launch

Provide Digital Ocean token and register etcd discovery token.

    $ . environments.sh

Update your ssh key reference in boot_coreos.sh before booting instances.

    $ ./boot_coreos.sh coreos-02
    $ ./boot_coreos.sh coreos-02

## Services startup

Inside CoreOS instance

    $ ssh core@<CoreOS instance IP>
    $ cd && git clone https://github.com/unicell/confd-etcd-demo.git
    $ fleetctl start ~/confd-etcd-demo/instances/*
    $ fleetctl start ~/confd-etcd-demo/static/nginx-lb.service

## Shining moment

From anywhere

    $ curl http://<Public IP of nginx-lb service>:80

From one of your CoreOS instances

    $ fleetctl journal -f nginx-lb.service
