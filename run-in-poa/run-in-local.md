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
docker run -it --name geth_poa_1 -e LANG=C.UTF-8 -p 10303:30303 -w /geth_bin -p 1545:8545 -p 1546:8546 -v /etc/localtime:/etc/localtime:ro -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash
docker run -it --name geth_poa_2 -e LANG=C.UTF-8 -p 20303:30303 -w /geth_bin -p 2545:8545 -p 2546:8546 -v /etc/localtime:/etc/localtime:ro -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash
docker run -it --name geth_poa_3 -e LANG=C.UTF-8 -p 30303:30303 -w /geth_bin -p 3545:8545 -p 3546:8546 -v /etc/localtime:/etc/localtime:ro -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash
docker run -it --name geth_poa_4 -e LANG=C.UTF-8 -p 40303:30303 -w /geth_bin -p 4545:8545 -p 4546:8546 -v /etc/localtime:/etc/localtime:ro -v $PWD:/geth_bin --network=geth_network ubuntu:18.04 bash

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

# 初始化
```
./geth --datadir /geth_data init /geth_bin/genesis_poa.json

```

# 导入私钥
```
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker exec -it geth_poa_1 bash
cp /geth_bin/node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json   /geth_data/keystore/

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker exec -it geth_poa_2 bash
cp /geth_bin/node2-0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69-39.105.153.126.json /geth_data/keystore/

cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
docker exec -it geth_poa_3 bash
cp /geth_bin/node3-0xecf8f6463e2b7264f0b93cf5bb4319aab2cc6a31.json /geth_data/keystore/

```


# 启动私链
```
cd /mnt/e/_git-source/github.com/spoonerAhua/my-eth/build/bin
./geth --datadir /geth_data --port "30303" --networkid "36050" --allow-insecure-unlock                                 \
    --miner.threads 1 --nodiscover --identity "private etherum" --graphql --graphql.corsdomain "*"  --graphql.vhosts "*"  \
    --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*" \
    --ws  --ws.addr 0.0.0.0 --ws.port 8546 --ws.api "eth,net,web3,miner,admin,debug,txpool,personal" --ws.origins    "*"

```

# 进入控制台
```
docker exec -it geth_poa_1 ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_poa_2 ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_poa_3 ./geth attach ipc:/geth_data/geth.ipc
docker exec -it geth_poa_4 ./geth attach ipc:/geth_data/geth.ipc
```

# 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://c203ebf1366f7aab2c6a24c6369835b621b3abb524a48af414a709927a8b0bccf92928943eca1c76953ad46e26d183d5a4cbfd4ebc85dade109d42878f74fa54@172.19.0.2:30303?discport=0")
admin.addPeer("enode://99c36feea2b9c12a03eda53295d11cf10e8fa1ce884e34a694c84234e31845c46558c05a9e7e9af94f111eea2e887d1bc35f770788d73ac9b82c6fc8026cce0e@172.19.0.3:30303?discport=0")
admin.addPeer("enode://2543e7c5659e6c80f451a01a8165279df4adff7977f906a780a3e6525d9a871967646e8242d80a914c60a1556533359d8165d4c09b2fcc14b6f5392be2dc0453@172.19.0.4:30303?discport=0")
admin.addPeer("enode://f559af874c68a0337d51c8eba79c88e4b56adc20b0f7f53dda9544d788f19d9ba1402bdd6080497691653a128505b97f65c45c8a7e68910699fad2704d9ccfd6@172.19.0.5:30303?discport=0")
net.peerCount
admin.peers # 查看邻居节点
```



# ----------------------------------------


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

# 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://0d15b550c0599be470d7d7c6d04b3bed0d0d7a8a238ad052b2a1dc487940c9489d699a775e5aac5bb81b313800348c0e7d9cef7e89d5434a98028c81255f2c68@172.19.0.2:30303?discport=0")
admin.addPeer("enode://f4a44c5eb9b16e8f8b15a3c32c9d330d4f9dedbb9bd32bdca618d2d412caa28e913dc791e9860f1400d3bf62d724752290525e3bf07df1fb47c7482e2ee9d129@172.19.0.3:30303?discport=0")
admin.addPeer("enode://a04bde56b45b5c969f40c9a487eb15969edcc27eb39ab86b30eb229c8fe934b18189c5a2f117ad711831bd644d7a0edd6c3c2d5cd14e57b82105c8a147731d48@172.19.0.4:30303?discport=0")
admin.addPeer("enode://2c98d86a43b313ea635d462d6606ba46373a9e59168d772d95c7565cafa7fc528987ed93ed1ae1883d5ba74ac8151f140e0006d7c444b0539f50299e86ecfee8@172.19.0.5:30303?discport=0")

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
