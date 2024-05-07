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

fi
