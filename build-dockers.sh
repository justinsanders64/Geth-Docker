#!/bin/bash

docker build -f dockerfile.ubuntu -t ubuntu-with-tools . && \
docker build --build-arg ACCOUNT_PASSWORD=boot -f dockerfile.manual -t geth-custom:boot . && \
docker build --build-arg ACCOUNT_PASSWORD=node1 -f dockerfile.manual -t geth-custom:node1 . && \
docker build --build-arg ACCOUNT_PASSWORD=node2 -f dockerfile.manual -t geth-custom:node2 . && \
docker build --build-arg ACCOUNT_PASSWORD=node3 -f dockerfile.manual -t geth-custom:node3 .