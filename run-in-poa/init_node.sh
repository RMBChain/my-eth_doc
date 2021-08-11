# # 初始化
/geth_bin/geth --datadir /my-eth/.utils/data init /geth_bin/genesis_sync.json

# # 启动私链
/my-eth/build/bin/geth --nodiscover --identity "private etherum" --datadir /my-eth/.utils/data --port "30303" --networkid "99854"    \
     --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpcapi "eth,net,web3,miner,admin,debug,txpool,personal" --rpccorsdomain "*"         \
     --ws  --allow-insecure-unlock

