# cardano-oracle-publisher

## Oracles on Cardano
There are two types of oracles on Cardano
- transaction metadata oracles
- oracle pools

## Transaction Metadata Oracles
Those oracles are for people that will have access to full blockchain, e.g those using. https://github.com/input-output-hk/cardano-db-sync
A typical use case for those oracles would be for light wallets, e.g. Yoroi, where they could simply show what was the price of ADA in USD/EUR at a given time in the past. This project addresses exactly these types of oracles.

## Oracle Pools
These oracles are needed for DeFi and for smart contracts, they for cases where a smart contract (in case of Cardano UTxO based) has full access to the blockchain. This project does not cover Oracle Pools.

## How to use oracle publisher?

To contribute to decentralization of the network one has to first configure metadata oracle publisher. That configuration consists of several steps:
- setup full / passive Cardano > 1.24.2 node
- configure oracle metadata file
- get personal access keys for oracles
- generate oracle file
- register oracle via metadata key: 1967
- configure cron to keep executing post.sh script at every hour
- optionally add your own oracles

## Requirements
- Full cardano passive node > 1.24.2 synced with the main blockchain
- local generated cardano address
- linux distro of choice

## Step by step guide

Firstly, we need to generate oracle metadata file, e.g.
```
{
  "name": "CardanoFans",
  "description": "CardanoFans - we believe in access to financial system for everybody",
  "ticker": "CRFA",
  "homepage": "https://cardano.fans",
  "address": "addr1v8yczm692pktwlvjfgwucrullt6af0lme7rh97fhfw2fgjc4chr79"
}
```

Please note for a functioning oracle only "address" from which transactions will be sent is necessary, the rest of fields are only used in case one has a stake pool and are optional for oracle-publisher.

Secondly, check metadata hash for this file
```
https://cardano.fans/mypool.metadata.json > mypool.metadata.json
cardano-cli stake-pool metadata-hash --pool-metadata-file mypool.metadata.json

5f1cbafbb46d8c8c92fae15e96170dbe6fba51cd66cda826d684bca3b0fad1bc
```

Thirdly, send a metadata transaction to Cardano blockchain with registration data
```
{
    "hash": "5f1cbafbb46d8c8c92fae15e96170dbe6fba51cd66cda826d684bca3b0fad1bc",
    "metadata": "https://cardano.fans/mypool.metadata.json"
}
```

Lastly, 
```
git clone https://github.com/matiwinnetou/cardano-oracle-publisher
```
add to the PATH

```
export PATH=cardano-oracle-publisher:$PATH
```

and add the scripts into your crontab
```
crontab -e
```

```
0 * * * * cardano-oracle-publisher/post.sh  
```
