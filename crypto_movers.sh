curl -s 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd' |
jq -r '[.[] | {name, symbol, price: .current_price, change: .price_change_percentage_24h}] |
 sort_by(-.change) |
 map([.symbol, (.price|tostring), (.change|tostring)]) |
 .[:15][] | @tsv' |
awk -F'\t' '{printf "%-8s $%-10s %+6.2f%%\n", $1, $2, $3}' |
head -15
