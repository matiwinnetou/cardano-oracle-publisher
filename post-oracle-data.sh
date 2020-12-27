#!/usr/bin/env bash
set -e
echo `date` Waking up...
export CARDANO_NODE_SOCKET_PATH=/run/cardano-node/node.socket
UTXOS=$(cardano-cli query utxo --address `cat /etc/secrets/mywallet.addr` --mainnet --allegra-era |  grep "^[^- ]" | sort -k 2n | tail -1)
TXHASH=$(echo $UTXOS | awk '{ print $1 }')
TXID=$(echo $UTXOS | awk '{ print $2 }')
BALANCE=$(echo $UTXOS | awk '{ print $3 }')
FEE=200000

TIP=$(cardano-cli query tip --mainnet | jq -r '.slotNo')
TTL=300

METADATAF=/tmp/oracle.json

echo `date` Fetching data points...
fetch-oracle-data.sh > $METADATAF
echo `date` Constructing tx...
cardano-cli transaction build-raw --allegra-era --tx-in ${TXHASH}#${TXID} --tx-out $(cat /home/mati/mywallet.addr)+$(($BALANCE-$FEE)) --fee 200000 --ttl $(($TIP+$TTL)) --out-file tx.raw --metadata-json-file $METADATAF
echo `date` Signing tx...
cardano-cli transaction sign --tx-body-file tx.raw --signing-key-file /etc/secrets/mywallet.skey --out-file tx.signed
echo `date` Posting tx...
cardano-cli transaction submit --tx-file tx.signed --mainnet
