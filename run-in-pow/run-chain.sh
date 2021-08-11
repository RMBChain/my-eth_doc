#! /bin/sh

echo "Starting my-eth..."

if [ ! -d "/my-eth/data/keystore" ];then
  echo "Init ETH datadir"
  /my-eth/chain/geth --datadir /my-eth/data init /my-eth/chain/genesis_pow.json
  cp /my-eth/chain/node1-0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5-39.105.18.23.json  /my-eth/data/keystore/
else
  echo "ETH has been inited before"
fi

sleep 5s

/my-eth/chain/geth --datadir /my-eth/data --port "30303" --networkid "99854" --identity "private etherum"                            \
    --http --http.addr 0.0.0.0 --http.port 8545 --http.corsdomain "*" --http.api "eth,web3,miner,admin,debug,txpool,personal,net"    \
    --ws   --ws.addr   0.0.0.0 --ws.port   8546 --ws.origins      "*"  --ws.api  "eth,web3,miner,admin,debug,txpool,personal,net"    \
    --graphql --graphql.corsdomain "*"     --graphql.vhosts "*"  --allow-insecure-unlock --syncmode full                             \
    --mine --miner.threads=1 --miner.etherbase=0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5                                            \
    --unlock 0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5 --password password.txt                                                      \
    --bootnodes "enode://13cb0c6dfb44dba984f4c2ecd5da797a0f74016fc7ca06ce3e8e6673cdeda0a9be0a71d2657a91fe97ffd26e3e879dda7aed299985e597997a3081f37d71c015@172.21.117.54:0?discport=33333"
