# cardano-oracle-publisher

# Oracles on Cardano
There are two types of oracles on Cardano
- transaction metadata oracles
- oracle pools

# Transaction Metadata Oracles
Those oracles are for people that will have access to full blockchain, e.g those using. https://github.com/input-output-hk/cardano-db-sync
A typical use case for those oracles would be for light wallets, e.g. Yoroi, where they could simply show what was the price of ADA in USD/EUR at a given time in the past. This project addresses exactly these types of oracles.

# Oracle Pools
These oracles are needed for DeFi and for smart contracts, they for cases where a smart contract (in case of Cardano UTxO based) has full access to the blockchain. This project does not cover Oracle Pools.

# How to use oracle publisher?

To contribute to decentralization of the network one has to first configure metadata oracle publisher. That configuration consists of several steps:
- setup full / passive Cardano > 1.24.2 node
- configure oracle metadata file
- get personal access keys for oracles
- generate oracle file
- register oracle via metadata key: 1967
- configure cron to keep executing post.sh script at every hour
- optionally add your own oracles

# Requirements
- Full cardano passive node > 1.24.2 synced with the main blockchain
- local generated cardano address
- linux distro of choice
