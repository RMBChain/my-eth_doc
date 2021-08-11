# 以太坊POA文档
- https://zoyi14.smartapps.cn/pages/note/index?slug=dcc9b6cb6722&origin=share&hostname=baiduboxapp&_swebfr=1
- https://blog.csdn.net/weixin_44257754/article/details/107937890
- https://blog.csdn.net/liuzhijun301/article/details/80784529

# 以太坊POA文档
./geth --datadir /eth-poa/node1 account new
./geth --datadir /eth-poa/node1 init spooner.json
./geth --datadir /eth-poa/node1 --port 10303  --nodiscover  --networkid "36050"  --syncmode "full"     \
       --rpc --rpcaddr 0.0.0.0 --rpcport 18545 --rpccorsdomain "*" --rpcapi "db,eth,net,web3,admin,personal,miner"  \
       --ws  --ws.addr 0.0.0.0 --ws.port 18546 --ws.origins "*" --ws.api "db,eth,net,web3,admin,personal,miner"    \
       --allow-insecure-unlock
./geth attach /eth-poa/node1/geth.ipc

./geth --datadir /eth-poa/node2 account new
./geth --datadir /eth-poa/node2 init spooner.json
./geth --datadir /eth-poa/node2 --port 20303  --nodiscover  --networkid "36050"  --syncmode "full"     \
       --rpc --rpcaddr 0.0.0.0 --rpcport 28545 --rpccorsdomain "*" --rpcapi "db,eth,net,web3,admin,personal,miner"  \
       --ws  --ws.addr 0.0.0.0 --ws.port 28546 --ws.origins "*" --ws.api "db,eth,net,web3,admin,personal,miner"      \
       --allow-insecure-unlock
./geth attach /eth-poa/node2/geth.ipc

./geth --datadir /eth-poa/node3 account new
./geth --datadir /eth-poa/node3 init spooner.json
./geth --datadir /eth-poa/node3 --port 30303  --nodiscover  --networkid "36050"  --syncmode "full"     \
       --rpc --rpcaddr 0.0.0.0 --rpcport 38545 --rpccorsdomain "*" --rpcapi "db,eth,net,web3,admin,personal,miner"  \
       --ws  --ws.addr 0.0.0.0 --ws.port 38546 --ws.origins "*" --ws.api "db,eth,net,web3,admin,personal,miner"      \
       --allow-insecure-unlock
./geth attach /eth-poa/node3/geth.ipc

admin.nodeInfo.enode
admin.addPeer("enode://8348738d1ae7951ed43d76f11b7d0123c914eeebc6330f79a0934705810145556b2d57535d02c782752f4c763cfbe36e78fbbdfcecd7c5786727a379fc2eecb2@127.0.0.1:10303?discport=0")
admin.addPeer("enode://a9c7be5599514ff04e7022027646494f09ec93b5c277585b63dc6532f9ffd44f1e71f44b4c41cd8e684509cf75daab91f56a27290c23f3b5893dd1bd86c1d4d9@127.0.0.1:20303?discport=0")
admin.addPeer("enode://b67039ff956adc3c01c80f03d6f3bf66e380e03cb40d1966efe5c31c66e40cfa1e44c4ae2434eb43a24ed3e8a5aac49767d1b0aa3231ea7547518fbde05e85df@127.0.0.1:30303?discport=0")


personal.unlockAccount(eth.coinbase,"123456",0)
personal.unlockAccount(eth.accounts[0],"123456",0)

var tx = {from: "0x3ce836868579cd121445c2fc31d23eecb787dfb5", to: "0x380936e3105286ebf1c4b9cc0240beef12eeb14e", value: web3.toWei(1.23, "ether")}
personal.sendTransaction(tx, "123456")

clique.propose("0x2a00cd98b2a532b347e49db87aba8e82b938e54d", true)
personal.unlockAccount("0x2a00cd98b2a532b347e49db87aba8e82b938e54d","123456",0)

