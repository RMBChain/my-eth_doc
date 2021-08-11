## 启动java
```
cd /my-eth
nohup java -jar web3j-app-1.0.0.jar &
```

## 启动bootnode(在39.105.18.23上，非docker)
```
cd /my-eth
./bootnode -genkey bootnode.key
./bootnode -nodekey bootnode.key -addr 172.21.117.54:33333
./bootnode -nodekey bootnode.key -addr 0.0.0.0:33333
nohup ./bootnode -nodekey bootnode.key -addr 0.0.0.0:33333 &
nohup ./bootnode -nodekey bootnode.key -addr 172.21.117.54:33333 >> bootnode.log  2>&1 &
nohup ./bootnode -nodekey bootnode.key -addr 172.21.117.54:33333 &
nohup ./bootnode -nodekey bootnode.key -addr 172.21.117.54:33333 >> bootnode.log  2>&1 &
```

enode://13cb0c6dfb44dba984f4c2ecd5da797a0f74016fc7ca06ce3e8e6673cdeda0a9be0a71d2657a91fe97ffd26e3e879dda7aed299985e597997a3081f37d71c015@172.21.117.54:0?discport=33333
## 启动私链
```
docker stop geth_pow
docker rm -f geth_pow
rm -r /my-eth/data/
rm -r /root/.ethereum
cd /my-eth/chain
chmod 777 *

// 39.105.18.23
docker rm -f geth_pow
cd /my-eth/chain
docker run -d --cpus="1.5" --restart always   --name geth_pow  --ipc=host  --net host  --hostname geth_pow  \
       -v /my-eth/chain:/my-eth/chain -v /my-eth/data/:/my-eth/data/ -w /my-eth/chain -v /etc/localtime:/etc/localtime:ro   \
       --entrypoint "/my-eth/chain/run-chain.sh" ubuntu:18.04
docker logs -f  geth_pow

/my-eth/chain/geth attach ipc:/my-eth/data/geth.ipc
            
docker exec -it geth_pow bash "ll /my-eth/data"
       
cp node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json   /my-eth-data/keystore/
cp node2-0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69-39.105.153.126.json /my-eth-data/keystore/   
docker start geth_pow
docker logs -f  geth_pow

docker exec -it geth_pow bash
docker exec -it geth_pow ./geth attach ipc:/my-eth/data/geth.ipc

docker exec -it geth_pow bash
cp node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json   /my-eth-data/keystore/
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
miner.setEtherbase("0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5")  // 39.105.18.23
miner.setEtherbase("0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69")  // 39.105.153.126
eth.coinbase
miner.start()

```

## 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://fc583c0bc82a56f16f8624e1f93b289b805171fb407f3b0c15089f5ee178d5c9b13663ab77e6a319cef98a500dffa074575986521fe14aceba5a834be51b8a30@60.205.218.238:30303")
admin.addPeer("enode://dda45e40b81bb9cde7c1b1cf30b5968bf705891d30cb4756c26709b618d1e18e6b535f25b556a19e0a65efca943fe0dd9d9056a7a44fd71f57b987ee676761f3@60.205.221.225:30303")
admin.addPeer("enode://3c241bb76573cc74dd5cb0c64316828e6d54f25c1de51c3bec4ca202fb4059458f5af990571825e07fbdfe20d3c9936e54c5d47cc50fa5ad037afa5f8e0b7714@39.105.153.126:30303")
admin.addPeer("enode://010dd99ff8ccaf0d60849386c4325002172cded4d0105766af3012173b13935ee522a368cfa9fae08f48c3085507c4ad48f020f9de838b6d2cabebbf869eca73@39.105.18.23:30303")

admin.addPeer("enode://fc583c0bc82a56f16f8624e1f93b289b805171fb407f3b0c15089f5ee178d5c9b13663ab77e6a319cef98a500dffa074575986521fe14aceba5a834be51b8a30@172.21.117.55:30303")
admin.addPeer("enode://dda45e40b81bb9cde7c1b1cf30b5968bf705891d30cb4756c26709b618d1e18e6b535f25b556a19e0a65efca943fe0dd9d9056a7a44fd71f57b987ee676761f3@172.21.117.56:30303")
admin.addPeer("enode://3c241bb76573cc74dd5cb0c64316828e6d54f25c1de51c3bec4ca202fb4059458f5af990571825e07fbdfe20d3c9936e54c5d47cc50fa5ad037afa5f8e0b7714@172.21.117.53:30303")
admin.addPeer("enode://010dd99ff8ccaf0d60849386c4325002172cded4d0105766af3012173b13935ee522a368cfa9fae08f48c3085507c4ad48f020f9de838b6d2cabebbf869eca73@172.21.117.54:30303")

```

## 查看日志
```
cd /my-eth
tail -f nohup.out
```
