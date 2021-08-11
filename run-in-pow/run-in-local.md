# 清理环境
```
wsl
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker rm -f geth_bootnode geth_pow_1 geth_pow_2 geth_pow_3
```

# 启动环境
```
docker network create geth_network
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker run -it -v /etc/localtime:/etc/localtime:ro -w /geth_bin -v $PWD:/geth_bin --name geth_bootnode -p 33333:33333                                              --network=geth_network ubuntu:18.04 bash
docker run -it -v /etc/localtime:/etc/localtime:ro -w /geth_bin -v $PWD:/geth_bin --name geth_pow_1    -p 10303:30303 -p 10303:30303/udp -p 1545:8545 -p 1546:8546 --network=geth_network ubuntu:18.04 bash
docker run -it -v /etc/localtime:/etc/localtime:ro -w /geth_bin -v $PWD:/geth_bin --name geth_pow_2    -p 20303:30303 -p 20303:30303/udp -p 2545:8545 -p 2546:8546 --network=geth_network ubuntu:18.04 bash
docker run -it -v /etc/localtime:/etc/localtime:ro -w /geth_bin -v $PWD:/geth_bin --name geth_pow_3    -p 30303:30303 -p 30303:30303/udp -p 3545:8545 -p 3546:8546 --network=geth_network ubuntu:18.04 bash

apt update
apt -y install iputils-ping net-tools
```

# 进入docker
```
docker exec -it geth_bootnode bash
docker exec -it geth_pow_1    bash
docker exec -it geth_pow_2    bash
docker exec -it geth_pow_3    bash

```

## 启动bootnode
```
docker exec -it geth_bootnode bash
./bootnode -genkey bootnode_test.key
./bootnode -nodekey bootnode_test.key -addr 172.19.0.2:33333
nohup ./bootnode -nodekey bootnode_test.key -addr 172.19.0.2:33333 &

```

# 初始化
```
./geth --datadir /geth_data init /geth_bin/genesis_pow.json

```

# 导入私钥
```
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker exec -it geth_pow_1 bash
cp /geth_bin/node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json   /geth_data/keystore/

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker exec -it geth_pow_2 bash
cp /geth_bin/node2-0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69-39.105.153.126.json /geth_data/keystore/

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker exec -it geth_pow_3 bash
cp /geth_bin/node3-0xecf8f6463e2b7264f0b93cf5bb4319aab2cc6a31.json /geth_data/keystore/

```


# 启动私链
```
./geth --datadir /geth_data --port "30303" --networkid "99854" --identity "private etherum"   --allow-insecure-unlock    \
    --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "eth,web3,miner,admin,debug,txpool,personal,net"  \
    --ws  --ws.addr 0.0.0.0 --ws.port 8546 --ws.origins    "*" --ws.api "eth,web3,miner,admin,debug,txpool,personal,net"  \
    --graphql --graphql.corsdomain "*"     --graphql.vhosts "*"                                                           \
    --bootnodes "enode://25c90372a3cd7f1ec3d41ef099d61e9a3d86d3654f23abedd9e34deee26afb11faae7bc267163809bf9a7ccdeb9d9f564d68c6f8a104ddd326f9b3c34923dc4b@172.19.0.2:0?discport=33333"

```

# 进入控制台
```
docker exec -it geth_bootnode ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_pow_1    ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_pow_2    ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_pow_3    ./geth attach ipc:/geth_data/geth.ipc

```
