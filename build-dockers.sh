#!/bin/bash

docker build -f dockerfile.ubuntu -t ubuntu-with-tools . && \
docker build --build-arg ACCOUNT_PASSWORD=boot --build-arg KEYSTORE=UTC--2024-04-01T21-58-09.571093932Z--4914b36a72e9378ece788213e7568fccd40495b1 -f dockerfile.manual -t geth-custom:boot . && \
docker build --build-arg ACCOUNT_PASSWORD=node1 --build-arg KEYSTORE=UTC--2024-04-01T21-58-29.113411418Z--647a111830ed27c68abb82baed7373ab1520bf68 -f dockerfile.manual -t geth-custom:node1 . && \
docker build --build-arg ACCOUNT_PASSWORD=node2 --build-arg KEYSTORE=UTC--2024-04-01T21-58-50.119870490Z--09822ea72a7cf2f55f66fe7f4116cf957eb206a8 -f dockerfile.manual -t geth-custom:node2 . && \
docker build --build-arg ACCOUNT_PASSWORD=node3 --build-arg KEYSTORE=UTC--2024-04-01T21-59-09.676167144Z--5c1ab2c0951ef2bf12243a587a2865ff41691967 -f dockerfile.manual -t geth-custom:node3 .