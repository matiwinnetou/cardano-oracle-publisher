#!/usr/bin/env bash
set -e

COIN_GECKO_CARDANO_JSON=$(curl -s 'https://api.coingecko.com/api/v3/coins/cardano?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false')
COIN_GECKO_BTC_JSON=$(curl -s 'https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false')
COIN_GECKO_AGI_JSON=$(curl -s 'https://api.coingecko.com/api/v3/coins/singularitynet?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false')
COIN_GECKO_ERGO_JSON=$(curl -s 'https://api.coingecko.com/api/v3/coins/ergo?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false')

CRYPTO_COMPARE_JSON=$(curl -s 'https://min-api.cryptocompare.com/data/pricemulti?fsyms=ADA,BTC,AGI&tsyms=BTC,USD,EUR&api_key=?')
ERGO_POOL_ADA_USD_JSON=$(curl -s "https://ada-usd-ergo-oracle.emurgo.io/frontendData" | sed -e 's/^.//' -e 's/.$//' -e 's/\\//g')
ERGO_POOL_ERG_USD_JSON=$(curl -s "https://erg-usd-ergo-oracle.emurgo.io/frontendData" | sed -e 's/^.//' -e 's/.$//' -e 's/\\//g')
MARKET_STACK_JSON=$(curl -s "http://api.marketstack.com/v1/intraday/latest?access_key=???&symbols=TSLA");
BTC_TREZOR_JSON=$(curl -s "https://btc1.trezor.io/api/v2")

DRAND=$(curl -s "https://api.drand.sh/public/latest" | jq 'del(.signature)' | jq 'del(.previous_signature)')

echo "{"
echo "  \"1968\": {"
echo "    \"ADAUSD\": ["
echo "       {"
echo "         \"value\": \"$(jq '.market_data.current_price.usd' <<< "$COIN_GECKO_CARDANO_JSON")\","
echo "         \"source\": \"coinGecko\""
echo "       },"
echo "       {"
echo "         \"value\": \"$(jq '.latest_price' <<< "$ERGO_POOL_ADA_USD_JSON")\","
echo "         \"source\": \"ergoOracles\""
echo "       }",
echo "       {"
echo "         \"value\": \"$(jq '.ADA.USD' <<< "$CRYPTO_COMPARE_JSON")\","
echo "         \"source\": \"cryptoCompare\""
echo "       }"
echo "    ],"
echo "    \"ADAEUR\": ["
echo "       {"
echo "         \"value\": \"$(jq '.market_data.current_price.eur' <<< "$COIN_GECKO_CARDANO_JSON")\","
echo "         \"source\": \"coinGecko\""
echo "       }",
echo "       {"
echo "         \"value\": \"$(jq '.ADA.EUR' <<< "$CRYPTO_COMPARE_JSON")\","
echo "         \"source\": \"cryptoCompare\""
echo "       }"
echo "    ],"
echo "    \"ADABTC\": ["
echo "       {"
echo "         \"value\": \"$(jq '.market_data.current_price.btc' <<< "$COIN_GECKO_CARDANO_JSON")\","
echo "         \"source\": \"coinGecko\""
echo "       },"
echo "       {"
echo "         \"value\": \"$(jq '.ADA.BTC' <<< "$CRYPTO_COMPARE_JSON")\","
echo "         \"source\": \"cryptoCompare\""
echo "       }"
echo "    ],"
echo "    \"BTCUSD\": ["
echo "       {"
echo "         \"value\": \"$(jq '.market_data.current_price.usd' <<< "$COIN_GECKO_BTC_JSON")\","
echo "         \"source\": \"coinGecko\""
echo "       }",
echo "       {"
echo "         \"value\": \"$(jq '.BTC.USD' <<< "$CRYPTO_COMPARE_JSON")\","
echo "         \"source\": \"cryptoCompare\""
echo "       }"
echo "    ],"
echo "    \"AGIUSD\": ["
echo "       {"
echo "         \"value\": \"$(jq '.market_data.current_price.usd' <<< "$COIN_GECKO_AGI_JSON")\","
echo "         \"source\": \"coinGecko\""
echo "       }",
echo "       {"
echo "         \"value\": \"$(jq '.AGI.USD' <<< "$CRYPTO_COMPARE_JSON")\","
echo "         \"source\": \"cryptoCompare\""
echo "       }"
echo "    ],"
echo "    \"BTCDIFF\": ["
echo "       {"
echo "         \"value\": \"$(jq -r '.backend.difficulty' <<< "$BTC_TREZOR_JSON")\","
echo "         \"source\": \"blockBook\""
echo "       }"
echo "    ],"
echo "    \"ERGUSD\": ["
echo "       {"
echo "         \"value\": \"$(jq '.market_data.current_price.usd' <<< "$COIN_GECKO_ERGO_JSON")\","
echo "         \"source\": \"coinGecko\""
echo "       },"
echo "       {"
echo "         \"value\": \"$(jq '.latest_price' <<< "$ERGO_POOL_ERG_USD_JSON")\","
echo "         \"source\": \"ergoOracles\""
echo "       }"
echo "    ],"
echo "    \"TSLA\": ["
echo "       {"
echo "         \"value\": \"$(jq '.data[].last' <<< "$MARKET_STACK_JSON")\","
echo "         \"source\": \"investorsExchange\""
echo "       }"
echo "    ],"
echo "    \"DRAND\": $DRAND"
echo "  }"
echo "}"⏎
