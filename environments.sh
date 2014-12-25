if [ -z "$DO_TOKEN" ]; then
    echo -n "Please input your token for Digital Ocean..."
    read -s DO_TOKEN
    export DO_TOKEN=$DO_TOKEN
fi  

export DISCOVERY_URL=`curl -fsS -X PUT https://discovery.etcd.io/new`
