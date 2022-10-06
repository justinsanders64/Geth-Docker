#!/bin/bash
# docker build --build-arg ACCOUNT_PASSWORD=boot -f dockerfile.geth -t geth-client:boot . && \
# docker build --build-arg ACCOUNT_PASSWORD=rpc -f dockerfile.geth -t geth-client:rpc . && \
# docker build --build-arg ACCOUNT_PASSWORD=node1 -f dockerfile.geth -t geth-client:node1 . && \
# docker build --build-arg ACCOUNT_PASSWORD=node2 -f dockerfile.geth -t geth-client:node2 . && \
docker build -f dockerfile.ubuntu -t ubuntu-with-tools . && \
docker build --build-arg ACCOUNT_PASSWORD=boot -f dockerfile.full -t geth-ubuntu:boot . && \
docker build --build-arg ACCOUNT_PASSWORD=rpc -f dockerfile.full -t geth-ubuntu:rpc . && \
docker build --build-arg ACCOUNT_PASSWORD=node1 -f dockerfile.full -t geth-ubuntu:node1 . && \
docker build --build-arg ACCOUNT_PASSWORD=node2 -f dockerfile.full -t geth-ubuntu:node2 .