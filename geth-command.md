## 进入控制台
```
cd /my-eth
/my-eth/geth attach ipc:/my-eth/data/geth.ipc
./geth attach ipc:/my-eth1/data/geth.ipc
./geth attach ws://39.105.18.23:8546
./geth attach ws://39.105.153.126:8546
./geth --exec "eth.blockNumber" attach ipc:/my-eth1/data/geth.ipc
./geth --exec 'loadScript("/mnt/e/ethereum/my-eth/echo.js")' attach ipc:/my-eth1/data/geth.ipc

personal.unlockAccount(eth.accounts[0],"123456")
miner.start()

personal.newAccount("123456") 
miner.start()

```

## 添加节点
```
admin.nodeInfo.enode
admin.addPeer("enode://c1e5e0d2c5d690326c05346282a088fb96f3829d06d27b33a514a49f82247ffcf0573efdab67ec3019168cc58d892f1a3a4925e9baddc78b348c56a0f2466fa2@39.105.153.126:30303")
admin.addPeer("enode://c1e5e0d2c5d690326c05346282a088fb96f3829d06d27b33a514a49f82247ffcf0573efdab67ec3019168cc58d892f1a3a4925e9baddc78b348c56a0f2466fa2@172.21.117.53:30303?discport=0")
admin.addPeer("enode://14e6185aedf049338abea9d5bfe50a59b2c32243590b2e0def43723b76555d4d4d0b5ffc4c4b5b6b50cd1291ad566e17d05752b9b54be8a27fdebad071cd28dc@39.105.18.23:30303")
admin.addPeer("enode://14e6185aedf049338abea9d5bfe50a59b2c32243590b2e0def43723b76555d4d4d0b5ffc4c4b5b6b50cd1291ad566e17d05752b9b54be8a27fdebad071cd28dc@172.21.117.54:30303?discport=0")
```

## 查看日志
```
cd /my-eth
tail -f nohup.out
```

## 以太坊操作
```
personal.unlockAccount(eth.accounts[0],"123456")
miner.start()

personal.newAccount("123456") 
miner.start()

eth.accounts # 查看账户
personal.listAccounts  # 查看账户
eth.getBalance(eth.accounts[0]) # 查看账户余额
eth.getBalance("0x752c9dD3E1e9Ca70708E42cc41C32d8E08707ac2") # 查看账户余额

miner.setEtherbase(eth.accounts[0]) # 设置挖矿地址
miner.start() # 启动挖矿
miner.stop() # 停止挖矿
admin.peers # 查看邻居节点
net.peerCount # 邻居节点数量
admin.nodeInfo # 节点信息
admin.nodeInfo.enode # 节点信息 enode://1f9edd7f3ea6646265e57a51d1ea41dc37c10a4f40496e4ebc1663433a344e833c54117491e4761f1ce70d3266f165d3782890d72c874b700d56a4b3c5360fdc@127.0.0.1:30303?discport=0
eth.blockNumber # 查看区块数
eth.getBlock(n)  # 查看区块信息
eth.getBlock('latest') # 查询最新的区块
eth.getTransaction(txNo) 
exit # 退出geth控制台
personal.unlockAccount(eth.accounts[0],"123456") # 解锁账号
eth.sendTransaction({from:eth.accounts[0],to:"0x64F5c3D36F51583d71AFab7FDf931C363D973c6b",value:web3.toWei(1,"ether")}) # 转账

web3.toWei(1,"ether")
web3.fromWei(1,"ether")
web3.fromWei('21000000000000', 'finney1');
```

