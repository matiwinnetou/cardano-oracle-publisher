#!/usr/bin/env bash                                                                                                                                                                                                                                                                                                    [7/845]
set -e
COINGECKOADAUSD=$(curl -s "https://api.coingecko.com/api/v3/coins/cardano?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false" | jq '.market_data.current_price.usd')
ERGOPOOLADAUSD=$(curl -s "https://ada-usd-ergo-oracle.emurgo.io/frontendData" | sed -e 's/^.//' -e 's/.$//' -e 's/\\//g' | jq '.latest_price')
ERGOPOOLERGUSD=$(curl -s "https://erg-usd-ergo-oracle.emurgo.io/frontendData" | sed -e 's/^.//' -e 's/.$//' -e 's/\\//g' | jq '.latest_price')

COINGECKOADAEUR=$(curl -s "https://api.coingecko.com/api/v3/coins/cardano?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false" | jq '.market_data.current_price.eur')

COINGECKOERGUSD=$(curl -s "https://api.coingecko.com/api/v3/coins/ergo?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false" | jq '.market_data.current_price.usd')

COINGECKOADABTC=$(curl -s "https://api.coingecko.com/api/v3/coins/cardano?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false" | jq '.market_data.current_price.btc')
COINGECKOBTCUSD=$(curl -s "https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false" | jq '.market_data.current_price.usd')

TESLASTOCKPRICE=$(curl -s "http://api.marketstack.com/v1/intraday/latest?access_key=??????&symbols=TSLA" | jq '.data[].last');

#BTCDIFF=$(curl -s "https://chain.api.btc.com/v3/block/latest" | jq '.data.difficulty')
BTCDIFF=$(curl -s "https://btc1.trezor.io/api/v2" | jq -r '.backend.difficulty')

COINGECKOAGIBTC=$(curl -s "https://api.coingecko.com/api/v3/coins/singularitynet?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false" | jq '.market_data.current_price.usd')
DRAND=$( curl -s "https://api.drand.sh/public/latest" | jq 'del(.signature)' | jq 'del(.previous_signature)')


echo "{"
echo "  \"1968\": {"
echo "    \"ADAUSD\": ["
echo "       {"
echo "         \"value\": \"$COINGECKOADAUSD\","
echo "         \"source\": \"coinGecko\""
echo "       },"
echo "       {"
echo "         \"value\": \"$ERGOPOOLADAUSD\","
echo "         \"source\": \"ergoOracles\""
echo "       }"
echo "    ],"
echo "    \"ADAEUR\": ["
echo "       {"
echo "         \"value\": \"$COINGECKOADAEUR\","
echo "         \"source\": \"coinGecko\""
echo "       }"
echo "    ],"
echo "    \"ADABTC\": ["
echo "       {"
echo "         \"value\": \"$COINGECKOADABTC\","
echo "         \"source\": \"coinGecko\""
echo "       }"
echo "    ],"
echo "    \"BTCUSD\": ["
echo "       {"
echo "         \"value\": \"$COINGECKOBTCUSD\","
echo "         \"source\": \"coinGecko\""
echo "       }"
echo "    ],"
echo "    \"AGIBTC\": ["
echo "       {"
echo "         \"value\": \"$COINGECKOAGIBTC\","
echo "         \"source\": \"coinGecko\""
echo "       }"
echo "    ],"
echo "    \"BTCDIFF\": ["
echo "       {"
echo "         \"value\": \"$BTCDIFF\","
echo "         \"source\": \"blockBook\""
echo "       }"
echo "    ],"
echo "    \"ERGUSD\": ["
echo "       {"
echo "         \"value\": \"$COINGECKOERGUSD\","
echo "         \"source\": \"coinGecko\""
echo "       },"
echo "       {"
echo "         \"value\": \"$ERGOPOOLERGUSD\","
echo "         \"source\": \"ergoOracles\""
echo "       }"
echo "    ],"
echo "    \"TSLA\": ["
echo "       {"
echo "         \"value\": \"$TESLASTOCKPRICE\","
echo "         \"source\": \"investorsExchange\""
echo "       }"
echo "    ],"
echo "    \"DRAND\": $DRAND"
echo "  }"
echo "}"
