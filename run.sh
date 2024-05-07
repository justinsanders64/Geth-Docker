#!/bin/bash
prysmctl testnet generate-genesis --fork capella --num-validators 64 --genesis-time-delay 10 --chain-config-file config.yml --geth-genesis-json-in genesis.json --geth-genesis-json-out genesis.json --output-ssz genesis.ssz
geth --datadir gethdata account import --password ~/password ~/$ACCOUNTKEYFILE
geth init --datadir gethdata ~/genesis.json && rm -f ~/gethdata/geth/nodekey
ip route del default
if [ $ACCOUNTKEYFILE == "bootnodekey" ]
then
    ip route add default via 10.1.0.2
    beacon-chain --datadir beacondata --min-sync-peers 0 --genesis-state genesis.ssz --bootstrap-node= --interop-eth1data-votes --chain-config-file config.yml \
        --contract-deployment-block 0 --chain-id 1234565 --accept-terms-of-use --jwt-secret jwt.hex --suggested-fee-recipient 0x44B3Cbc9d59738A89B974c12623Cf5219C3b6b32 \
        --minimum-peers-per-subnet 0 --enable-debug-rpc-endpoints --execution-endpoint gethdata/geth.ipc > ~/beacon.log 2>&1 &
    validator --datadir validatordata --accept-terms-of-use --interop-num-validators 64 --chain-config-file config.yml > ~/validator.log 2>&1 &
    geth --nodekeyhex 3028271501873c4ecf501a2d3945dcb64ea3f27d6f163af45eb23ced9e92d85b --http --http.addr 0.0.0.0 --http.port 8545 --http.api eth,net,web3 --http.corsdomain '*' \
        --ws --ws.api eth,net,web3 --ws.origins '*' --netrestrict 10.1.0.0/22 --nat extip:10.1.0.10 --port 30303 --networkid 1234565 --authrpc.jwtsecret jwt.hex --syncmode full \
        --datadir gethdata --allow-insecure-unlock --unlock 0x44B3Cbc9d59738A89B974c12623Cf5219C3b6b32 --password ~/password
elif [ $ACCOUNTKEYFILE == "node1key" ]
then
    ip route add default via 10.1.1.2
    beacon-chain --datadir beacondata --min-sync-peers 0 --genesis-state genesis.ssz \
        --bootstrap-node=enr:-MK4QPapdv2rDTQkSL8S6ElrCGg9cabfL4j6Ko5BFPwxJ008BXYzuDSqeqCzAnOXQ0jv-7kQnpvMAwOQ6IUrp4ve_GyGAY89RTSZh2F0dG5ldHOIAwAAAAAAAACEZXRoMpBa8xKTIAAAkwAdBAAAAAAAgmlkgnY0gmlwhAoBAAqJc2VjcDI1NmsxoQOm-pFj0cyMnsbcmBeUBnND-bG03jVJOgd9UeOYglE9rohzeW5jbmV0cw-DdGNwgjLIg3VkcIIu4A \
        --interop-eth1data-votes --chain-config-file config.yml --contract-deployment-block 0 --chain-id 1234565 --accept-terms-of-use --jwt-secret jwt.hex --suggested-fee-recipient 0xD4ED63fD37a8a8746832f20Ef349089c8319b54C \
        --minimum-peers-per-subnet 0 --enable-debug-rpc-endpoints --execution-endpoint gethdata/geth.ipc --p2p-udp-port 12001 --p2p-tcp-port 13001 --grpc-gateway-port 3501 --rpc.port 4001 > ~/beacon.log 2>&1 &
    geth --nodekeyhex 3028271501873c4ecf501a2d3945dcb64ea3f27d6f163af45eb23ced9e92d85b \
        --netrestrict 10.1.0.0/22 --nat extip:10.1.1.10 --port 30304 --networkid 1234565 --authrpc.jwtsecret jwt.hex --syncmode full \
        --datadir gethdata --allow-insecure-unlock --unlock 0xD4ED63fD37a8a8746832f20Ef349089c8319b54C --password ~/password --authrpc.port 8552
elif [ $ACCOUNTKEYFILE == "node2key" ]
then
    ip route add default via 10.1.2.2
    beacon-chain --datadir beacondata --min-sync-peers 0 --genesis-state genesis.ssz \
        --bootstrap-node=enr:-MK4QPapdv2rDTQkSL8S6ElrCGg9cabfL4j6Ko5BFPwxJ008BXYzuDSqeqCzAnOXQ0jv-7kQnpvMAwOQ6IUrp4ve_GyGAY89RTSZh2F0dG5ldHOIAwAAAAAAAACEZXRoMpBa8xKTIAAAkwAdBAAAAAAAgmlkgnY0gmlwhAoBAAqJc2VjcDI1NmsxoQOm-pFj0cyMnsbcmBeUBnND-bG03jVJOgd9UeOYglE9rohzeW5jbmV0cw-DdGNwgjLIg3VkcIIu4A \
        --interop-eth1data-votes --chain-config-file config.yml --contract-deployment-block 0 --chain-id 1234565 --accept-terms-of-use --jwt-secret jwt.hex --suggested-fee-recipient 0xcC9Ca1a6B77Fec6e53dA34F132D7ABD8aBb250d7 \
        --minimum-peers-per-subnet 0 --enable-debug-rpc-endpoints --execution-endpoint gethdata/geth.ipc > ~/beacon.log 2>&1 &
    geth --nodekeyhex 3028271501873c4ecf501a2d3945dcb64ea3f27d6f163af45eb23ced9e92d85b \
        --netrestrict 10.1.0.0/22 --nat extip:10.1.2.20 --port 30305 --networkid 1234565 --authrpc.jwtsecret jwt.hex --syncmode full \
        --datadir gethdata --allow-insecure-unlock --unlock 0xcC9Ca1a6B77Fec6e53dA34F132D7ABD8aBb250d7 --password ~/password
else
    ip route add default via 10.1.3.2
    beacon-chain --datadir beacondata --min-sync-peers 0 --genesis-state genesis.ssz \
        --bootstrap-node=enr:-MK4QPapdv2rDTQkSL8S6ElrCGg9cabfL4j6Ko5BFPwxJ008BXYzuDSqeqCzAnOXQ0jv-7kQnpvMAwOQ6IUrp4ve_GyGAY89RTSZh2F0dG5ldHOIAwAAAAAAAACEZXRoMpBa8xKTIAAAkwAdBAAAAAAAgmlkgnY0gmlwhAoBAAqJc2VjcDI1NmsxoQOm-pFj0cyMnsbcmBeUBnND-bG03jVJOgd9UeOYglE9rohzeW5jbmV0cw-DdGNwgjLIg3VkcIIu4A \
        --interop-eth1data-votes --chain-config-file config.yml --contract-deployment-block 0 --chain-id 1234565 --accept-terms-of-use --jwt-secret jwt.hex --suggested-fee-recipient 0x8D56B0225D863d29b5D80d5aAAe2Ee249361D9ac \
        --minimum-peers-per-subnet 0 --enable-debug-rpc-endpoints --execution-endpoint gethdata/geth.ipc > ~/beacon.log 2>&1 &
    geth --nodekeyhex 3028271501873c4ecf501a2d3945dcb64ea3f27d6f163af45eb23ced9e92d85b \
        --netrestrict 10.1.0.0/22 --nat extip:10.1.3.30 --port 30306 --networkid 1234565 --authrpc.jwtsecret jwt.hex --syncmode full \
        --datadir gethdata --allow-insecure-unlock --unlock 0x8D56B0225D863d29b5D80d5aAAe2Ee249361D9ac --password ~/password
fi
