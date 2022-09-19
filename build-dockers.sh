#!/bin/bash
docker build -f dockerfile -t geth-client . && \
docker build -f dockerfile.node1 -t geth-client/node1 . && \
docker build -f dockerfile.node2 -t geth-client/node2 .