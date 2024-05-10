# GETH Docker Private Environment

To instantly spin up a development/private Ethereum network made up of Go-Ethereum clients/nodes (GETH).

## Description

In depth description tbd.

Do not use accounts on MainNet as private keys are contained in files on this repo
- 0x44B3Cbc9d59738A89B974c12623Cf5219C3b6b32
- 0xD4ED63fD37a8a8746832f20Ef349089c8319b54C
- 0xcC9Ca1a6B77Fec6e53dA34F132D7ABD8aBb250d7
- 0x8D56B0225D863d29b5D80d5aAAe2Ee249361D9ac

## Getting Started

### Dependencies

* Must have the ability to run docker in any form (docker-desktop), windows, wsl, etc.
* Docker-Compose 
* Internet connectivity

### Building the Dockers

The dockers must be manually built prior to running "docker-compose up" run
```
./build-dockers.sh
```
in the root of the project.
This will create two images:
* ubuntu-with-tools - simple baseline ubuntu image used for routing with some networking tools installed
* geth-ubuntu - ubuntu with the geth client installed

Several tags will be created from the geth-ubuntu
* boot - for the bootnode of the network
* rpc - for the rpc client of the network
* node1 - the standalone geth client that will mine on the network
* node2 - the standalone geth client that will be used to transact with

### Executing program

* It is as simple as running the following
```
docker-compose up
```
* If all goes accordingly, the 4 dockers should be communicating, on different subnets

## Help

Reach out to Joshua Kemp @ kemp3jm@dukes.jmu.edu

## Authors

Contributors names and contact info

* Joshua Kemp

Modifications made for Proof of Stake

* Justin Sanders

## Version History

* 1.0
    * Final Version - Ready for testing
* 0.2
    * Various bug fixes and optimizations 
* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

* TBD
