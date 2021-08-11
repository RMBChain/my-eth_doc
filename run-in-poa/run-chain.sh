/my-eth/geth --datadir /my-eth-data init /my-eth/genesis_pow.json

/my-eth/geth --datadir /my-eth-data --port "30303" --networkid "99854" --identity "private etherum"   --allow-insecure-unlock    \
    --rpc --rpcaddr 0.0.0.0 --rpcport 8545 --rpccorsdomain "*" --rpcapi "eth,web3,miner,admin,debug,txpool,personal,net"  \
    --ws  --ws.addr 0.0.0.0 --ws.port 8546 --ws.origins    "*" --ws.api "eth,web3,miner,admin,debug,txpool,personal,net"  \
    --graphql --graphql.corsdomain "*"     --graphql.vhosts "*"                                                           \
    --bootnodes "enode://3e162c939a18ae974e8144e181045a4beadd4b779420fc603d2e3f28a184da8314f5d54bacd25b12e1becf684e799e0994dd199c2c984a19b62d9945c9ffaf27@172.21.117.54:0?discport=33333"
