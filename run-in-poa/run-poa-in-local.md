# 清理环境
```
wsl
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker rm -f geth_poa_1 geth_poa_2 geth_poa_3 geth_poa_4
```

# 启动环境
```
docker network create geth_network
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker run -it --name geth_poa_1 -e LANG=C.UTF-8 -p 10303:30303 -w /geth_bin -p 1545:8545 -p 1546:8546 -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash
docker run -it --name geth_poa_2 -e LANG=C.UTF-8 -p 20303:30303 -w /geth_bin -p 2545:8545 -p 2546:8546 -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash
docker run -it --name geth_poa_3 -e LANG=C.UTF-8 -p 30303:30303 -w /geth_bin -p 3545:8545 -p 3546:8546 -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash
docker run -it --name geth_poa_4 -e LANG=C.UTF-8 -p 40303:30303 -w /geth_bin -p 4545:8545 -p 4546:8546 -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash

apt update
apt -y install iputils-ping net-tools
```

# 进入docker
```
docker exec -it geth_poa_1 bash
docker exec -it geth_poa_2 bash
docker exec -it geth_poa_3 bash
docker exec -it geth_poa_4 bash
```

# 启动bootnode
```
./bootnode -genkey bootnode_test.key
./bootnode -nodekey bootnode_test.key -addr 172.19.0.5:30303
```

# 初始化
```
./geth --datadir /geth_data init /geth_bin/poatest.json

```

# 启动私链
```
// node 1
./geth --datadir /geth_data --port "30303" --networkid "36050" --allow-insecure-unlock --syncmode "full"                  \
    --miner.threads 1 --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*"  \
    --ws  --ws.addr 0.0.0.0 --ws.port 8546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"  \
    --unlock 0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5 --password password.txt       \
    --bootnodes "enode://bdd774c9a3f211e0dba394b2238528a5cf24988a0a223b2a7efdb6242af54ef5315e5e0ab8b56e7eb73b32e5ab7ea2893f401db15570c56e8ba82f2249ed7091@172.19.0.5:0?discport=30303"

// node 2
./geth --datadir /geth_data --port "30303" --networkid "36050" --allow-insecure-unlock --syncmode "full"                  \
    --miner.threads 1 --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*"  \
    --ws  --ws.addr 0.0.0.0 --ws.port 8546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"  \
    --unlock 0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69 --password password.txt       \
    --bootnodes "enode://bdd774c9a3f211e0dba394b2238528a5cf24988a0a223b2a7efdb6242af54ef5315e5e0ab8b56e7eb73b32e5ab7ea2893f401db15570c56e8ba82f2249ed7091@172.19.0.5:0?discport=30303"

// node 3
./geth --datadir /geth_data --port "30303" --networkid "36050" --allow-insecure-unlock --syncmode "full"                  \
    --miner.threads 1 --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*"  \
    --ws  --ws.addr 0.0.0.0 --ws.port 8546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"  \
    --unlock 0xecf8f6463e2b7264f0b93cf5bb4319aab2cc6a31 --password password.txt       \
    --bootnodes "enode://bdd774c9a3f211e0dba394b2238528a5cf24988a0a223b2a7efdb6242af54ef5315e5e0ab8b56e7eb73b32e5ab7ea2893f401db15570c56e8ba82f2249ed7091@172.19.0.5:0?discport=30303"


```

# 导入私钥
```
docker exec -it geth_poa_1 bash
cp /geth_bin/node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json   /geth_data/keystore/

docker exec -it geth_poa_2 bash
cp /geth_bin/node2-0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69-39.105.153.126.json /geth_data/keystore/

docker exec -it geth_poa_3 bash
cp /geth_bin/node3-0xecf8f6463e2b7264f0b93cf5bb4319aab2cc6a31.json /geth_data/keystore/

```


# 进入控制台
```
./geth attach ipc:/geth_data/geth.ipc

docker exec -it geth_poa_1 ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_poa_2 ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_poa_3 ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_poa_4 ./geth attach ipc:/geth_data/geth.ipc


```

# 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://37244c3eb9dc1b7d2e95b9006ac3eeaea100a017e752590e3849d5c6482cea74f3b5311d2a73fea9dfffa55353021b860026d459ce91e1da1989d4412a5dd418@172.19.0.2:30303?discport=0")
admin.addPeer("enode://b44e866ae5573bfb22223b51ea377c31b4987d3e8664933be9641c863cbfcacece6302eb6342e1582b2ce1f284bd51c4fefecc857483714c20f0f7d889914268@172.19.0.3:30303?discport=0")
admin.addPeer("enode://72db62bc915e0b9d686990370b1f0fcc3fea6215ff4f40b2c82b7d3d79cf43d6c756c67b98a04f15a7a102f6bbdbb0e054db4102b6f586beeeb4f30b50568048@172.19.0.4:30303?discport=0")
admin.addPeer("enode://9fbbaf05dfe1d20c59a7288057d9c00d445569421a9f8812fed846ab663521d4df1081d36adebd4c55d04f027fbe68cb0379d010b5af2f7689fa1195dacef039@172.19.0.5:30303?discport=0")
net.peerCount
admin.peers # 查看邻居节点
```



# ----------------------------------------


# 以太坊操作
```
personal.unlockAccount(eth.accounts[0],"123456")
personal.newAccount("123456") 
miner.start()
clique.getSigners()  // 查看签名账号

eth.accounts # 查看账户
personal.listAccounts  # 查看账户
eth.getBalance(eth.accounts[0]) # 查看账户余额
miner.setEtherbase(eth.accounts[0]) # 设置挖矿地址
miner.start() # 启动挖矿
miner.stop() # 停止挖矿
net.peerCount # 邻居节点数量
admin.nodeInfo # 节点信息
admin.nodeInfo.enode # 节点信息 enode://1f9edd7f3ea6646265e57a51d1ea41dc37c10a4f40496e4ebc1663433a344e833c54117491e4761f1ce70d3266f165d3782890d72c874b700d56a4b3c5360fdc@127.0.0.1:30303?discport=0
eth.blockNumber # 查看区块数
eth.getBlock(n)  # 查看区块信息
eth.getBlock('latest') # 查询最新的区块
eth.getTransaction(txNo) # 查询交易，根据交易号txNo，交易号是产生一个交易后返回的一串16进制字符。
exit # 退出geth控制台
personal.unlockAccount(eth.accounts[0],"123456") // 解锁账号
eth.sendTransaction({from:"85564bfb7d913cc7ca84f3b325cdf239b950c3f5",to:"ecf8f6463e2b7264f0b93cf5bb4319aab2cc6a31",value:web3.toWei(1,"ether")}) // 转账
eth.sendTransaction({from:"c65bc7f6de6c366d48d531d57bb7f41d79a63a69",to:"85564bfb7d913cc7ca84f3b325cdf239b950c3f5",value:web3.toWei(1,"ether")}) // 转账
eth.sendTransaction({from:"ecf8f6463e2b7264f0b93cf5bb4319aab2cc6a31",to:"c65bc7f6de6c366d48d531d57bb7f41d79a63a69",value:web3.toWei(1,"ether")}) // 转账
eth.syncing 查看同步状态
web3.toWei(1,"ether")
web3.fromWei(1,"ether")
web3.fromWei('21000000000000', 'finney1');

```

# 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://9234ff1a5c6a39e7df94c127d2d201e0a5323e2a8fb031fc0e664d126af604067d0625e9a24f776461d32ca792c9222b2584de3e154c6acea120e41548eebf47@172.19.0.2:30303?discport=0")
admin.addPeer("enode://2c7084383eed6900c492bd12a4416183d439e5fd61af9c2274f8810929cb420bea3f938d0b3d474928e82993e749638be019c22ad67c38b9939dc739d660e4ac@172.19.0.3:30303?discport=0")
admin.addPeer("enode://be001a1395dd497f7cc9d61f569858985fbfe5bfb8c293783c28849c6917da04267705ada10ec4e4242e7937874f75ca78a0612a480f44d52460fc78ee330f9e@172.19.0.4:30303?discport=0")
admin.addPeer("enode://58cd95391c5a65b5db735ebccf59d18958c0ba2417127327cedbfb1911be4ef4e31965a2534934ecd06c3cc1bc2a59fcd483aa569de5014b1096a7fc78c84723@172.19.0.5:30303?discport=0")
net.peerCount

```




# 清理环境
```
rm -r /my-eth/node1
rm -r /my-eth/node2
rm -r /my-eth/node3
rm -r /my-eth/node4
```

# 创建目录
```
mkdir /my-eth/node1
mkdir /my-eth/node2
mkdir /my-eth/node3
mkdir /my-eth/node4
```

# 初始化node
```
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth --datadir /my-eth/node1 init genesis_poa.json
./geth --datadir /my-eth/node2 init genesis_poa.json
./geth --datadir /my-eth/node3 init genesis_poa.json
./geth --datadir /my-eth/node4 init genesis_poa.json
```

# 启动环境
```
apt update
apt -y install iputils-ping net-tools

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth --datadir /my-eth/node1 --port "10303" --networkid "36050" --allow-insecure-unlock                                 \
    --miner.threads 1 --nodiscover --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 18545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*" \
    --ws  --ws.addr 0.0.0.0 --ws.port 18546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth --datadir /my-eth/node2 --port "20303" --networkid "36050" --allow-insecure-unlock                                 \
    --miner.threads 1 --nodiscover --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 28545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*" \
    --ws  --ws.addr 0.0.0.0 --ws.port 28546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth --datadir /my-eth/node3 --port "30303" --networkid "36050" --allow-insecure-unlock                                 \
    --miner.threads 1 --nodiscover --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 38545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*" \
    --ws  --ws.addr 0.0.0.0 --ws.port 38546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth --datadir /my-eth/node4 --port "40303" --networkid "36050" --allow-insecure-unlock                                 \
    --miner.threads 1 --nodiscover --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 48545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*" \
    --ws  --ws.addr 0.0.0.0 --ws.port 48546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"

```

# 进入控制台
```
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth attach ipc:/my-eth/node1/geth.ipc

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth attach ipc:/my-eth/node2/geth.ipc

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth attach ipc:/my-eth/node3/geth.ipc

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth attach ipc:/my-eth/node4/geth.ipc

```

# 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://c3d690697480de7d743075d38d4d8b74671a1586155326671c8e59069f61f8f517e75d94963d6ed89bfdf226e4e03b3189f4e7d2cee97984e95bb5f0cb4736ce@127.0.0.1:10303?discport=0")
admin.addPeer("enode://218854fd7681b5e16d61854b1b56cd396488c9893a9144fc724d8cb6f34be95fe0cb5b696d3e1f367301b6d84e385fa8daff1ba43165fc72153c52aed4f5b8f1@127.0.0.1:20303?discport=0")
admin.addPeer("enode://5cccf57efcc97e2d5b0283e813777c3b7f299883d347bb59b5b4c17ac7bc1d1abb72a91f5dc48abb95edff9ada621500e0b01e51a1026c18092f7308f7c5cb5d@127.0.0.1:30303?discport=0")
admin.addPeer("enode://19a2e82cbe6a88af703964c77980190da7f7b1f68c5d639e47a55c0c7008d59d483931d03b2b42d00a57d1b6c9fb9227fd6d2c4d29aeb8e7f4b10452eb55d189@127.0.0.1:40303?discport=0")
net.peerCount
```

# 以太坊操作
```
personal.unlockAccount(eth.accounts[0],"123456")
personal.newAccount("123456") 
miner.start()

eth.accounts # 查看账户
personal.listAccounts  # 查看账户
eth.getBalance(eth.accounts[0]) # 查看账户余额
miner.setEtherbase(eth.accounts[0]) # 设置挖矿地址
miner.start() # 启动挖矿
miner.stop() # 停止挖矿
net.peerCount # 邻居节点数量
admin.nodeInfo # 节点信息
admin.nodeInfo.enode # 节点信息 enode://1f9edd7f3ea6646265e57a51d1ea41dc37c10a4f40496e4ebc1663433a344e833c54117491e4761f1ce70d3266f165d3782890d72c874b700d56a4b3c5360fdc@127.0.0.1:30303?discport=0
eth.blockNumber # 查看区块数
eth.getBlock(n)  # 查看区块信息
eth.getBlock('latest') # 查询最新的区块
eth.getTransaction(txNo) # 查询交易，根据交易号txNo，交易号是产生一个交易后返回的一串16进制字符。
exit # 退出geth控制台
personal.unlockAccount(eth.accounts[0],"123456") # 解锁账号
eth.sendTransaction({from:eth.accounts[0],to:"0x752c9dD3E1e9Ca70708E42cc41C32d8E08707ac2",value:web3.toWei(21,"ether")}) # 转账
eth.syncing 查看同步状态
web3.toWei(1,"ether")
web3.fromWei(1,"ether")
web3.fromWei('21000000000000', 'finney1');

```
