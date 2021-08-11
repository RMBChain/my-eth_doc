## 启动java
```
java -jar web3j-app-1.0.0.jar
```

## 启动bootnode
```
cd /my-eth
./bootnode -genkey bootnode_test.key
./bootnode -nodekey bootnode_test.key -addr 172.21.117.54:30303
nohup ./bootnode -nodekey bootnode_test.key -addr 172.21.117.54:33333 &

```

## 启动私链
```
docker rm -f geth_pow
rm -r /my-eth-data/
cd /my-eth
chmod 777 *

docker run -d --cpuset-cpus="1-2" --restart always   --name geth_pow  \
       -v /my-eth/:/my-eth/ -v /my-eth-data/:/my-eth-data/ -w /my-eth \
       --ipc=host  --net host -v /etc/localtime:/etc/localtime:ro    \
       ubuntu:18.04 bash -c "/my-eth/run-chain.sh"

docker logs -f  geth_pow
docker exec -it geth_pow bash
docker exec -it geth_pow ./geth attach ipc:/my-eth-data/geth.ipc

docker logs -f  geth_pow
cp node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json /my-eth-data/keystore/
cp node2-0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69-39.105.153.126.json /my-eth-data/keystore/
miner.setEtherbase("0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5")
miner.setEtherbase("0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69")

```

## 进入控制台
```
cd /my-eth
/my-eth/geth attach ipc:/my-eth-data/geth.ipc
./geth attach ipc:/my-eth1/data/geth.ipc
./geth attach ws://39.105.18.23:8546
./geth attach ws://39.105.153.126:8546
./geth console ws://39.105.153.126:8546

./geth --exec "eth.blockNumber" attach ipc:/my-eth1/data/geth.ipc
./geth --exec 'loadScript("/mnt/e/ethereum/my-eth/echo.js")' attach ipc:/my-eth1/data/geth.ipc

personal.unlockAccount(eth.accounts[0],"123456")
miner.start()

personal.newAccount("123456") 
miner.setEtherbase("0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5")
miner.setEtherbase("0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69")
eth.coinbase
miner.start()

```

## 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://a6f47ef88878a3ce05451f350e40eb358915b263a5746a40963fd708c46b12fe1e10b2e316b221221be39781b576ed92f6648a040f609fb0c0a5d6017fbbaa47@39.105.18.23:30303")
admin.addPeer("enode://131fed49e5e84db939635da0648c70753d5468e9ec7815fc4996a115cf3d539df67ece70f189589c45be5f47846157554caebf14911ea71a254f59943469a517@39.105.153.126:30303")
```

## 查看日志
```
cd /my-eth
tail -f nohup.out
```
