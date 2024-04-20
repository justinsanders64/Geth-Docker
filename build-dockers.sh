#!/bin/bash

docker build -f dockerfile.ubuntu -t ubuntu-with-tools . && \
docker build --build-arg ACCOUNT_PASSWORD=boot --build-arg ACCOUNT=bootnodekey -f dockerfile.manual -t geth-custom:boot . && \
docker build --build-arg ACCOUNT_PASSWORD=node1 --build-arg ACCOUNT=node1key -f dockerfile.manual -t geth-custom:node1 . && \
docker build --build-arg ACCOUNT_PASSWORD=node2 --build-arg ACCOUNT=node2key -f dockerfile.manual -t geth-custom:node2 . && \
docker build --build-arg ACCOUNT_PASSWORD=node3 --build-arg ACCOUNT=node3key -f dockerfile.manual -t geth-custom:node3 .