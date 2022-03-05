WITH liquidity AS (
    SELECT DATE_TRUNC('minute', call_block_time) AS time,
    output__reserve0/1e6 AS USDC,
    output__reserve1/1e18 AS ETH
    FROM uniswap_v2."Pair_call_getReserves"
    WHERE contract_address = '\xb4e16d0168e52d35cacd2c6185b44281ec28c9dc' --Uniswap V2 USDC/ETH Pair Address
    AND call_success = 'true'
    AND call_block_time > now() - interval '180 days'
),

usdc_p AS (
    SELECT minute AS time, 
    price AS usdc_price
    FROM prices."usd"
    WHERE symbol = 'USDC'
    AND minute > now() - interval '180 days'
),

eth_p AS (
    SELECT minute AS time,
    price AS eth_price
    FROM prices."layer1_usd"
    WHERE symbol = 'ETH'
    AND minute > now() - interval '180 days'
),

full_table AS (
    SELECT liquidity.time,
    liquidity.USDC,
    liquidity.ETH,
    usdc_p.usdc_price
    FROM liquidity
    JOIN usdc_p
    ON (liquidity.time = usdc_p.time)
),

full_table2 AS (
    SELECT full_table.time, full_table.usdc, full_table.eth, full_table.usdc_price, eth_p.eth_price
    FROM full_table
    JOIN eth_p
    ON (full_table.time = eth_p.time)
),

final_table AS (
    SELECT time,
    usdc * usdc_price AS usdc_liquidity$,
    eth * eth_price AS eth_liquidity$
    FROM full_table2)

SELECT time, 
AVG(usdc_liquidity$ + eth_liquidity$) AS total_liquidity_USD
FROM final_table
GROUP BY time
ORDER BY time;

