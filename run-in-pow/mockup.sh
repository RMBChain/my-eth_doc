
while(true)
do

curl http://localhost:8545 -X POST --header "Content-Type: application/json" -d '{
    "jsonrpc":"2.0",
    "method":"personal_unlockAccount",
    "params":[
        "0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5",
        "123456"
    ],
    "id":76111111
}' 

curl http://localhost:8545 -X POST  --header "Content-Type: application/json" -d '{
    "jsonrpc":"2.0",
    "method":"eth_sendTransaction",
    "id":76111111,
    "params": [{
        "from": "0x85564bfb7d913cc7ca84f3b325cdf239b950c3f5",
        "to": "0xc65bc7f6de6c366d48d531d57bb7f41d79a63a69",
        "gas":"0x76c0", 
        "gasPrice": "0x9184e72a000",
        "value": "0x10000000000000"
    }]
}'

sleep 15s

done
