WITH uni_vol AS (
    SELECT DATE_TRUNC('day', block_time) AS time,
    ROUND(SUM(usd_amount)) AS Uniswap_Volume
    FROM dex.trades
    WHERE project = 'Uniswap'
    AND block_time > now() - interval '250 days'
    GROUP BY time
    ORDER BY time
),
    
sushi_vol AS (
    SELECT DATE_TRUNC('day', block_time) AS time,
    ROUND(SUM(usd_amount)) AS Sushiswap_Volume
    FROM dex.trades
    WHERE project = 'Sushiswap'
    AND block_time > now() - interval '250 days'
    GROUP BY time
    ORDER BY time
),

balancer_vol AS (
    SELECT DATE_TRUNC('day', block_time) AS time,
    ROUND(SUM(usd_amount)) AS Balancer_Volume
    FROM dex.trades
    WHERE project = 'Balancer'
    AND block_time > now() - interval '250 days'
    GROUP BY time
    ORDER BY time
),

dYdX_vol AS (
    SELECT DATE_TRUNC('day', block_time) AS time,
    SUM(usd_amount) AS dYdX_Volume
    FROM dex.trades
    WHERE project = 'dYdX'
    AND block_time > now() - interval '250 days'
    GROUP BY time
    ORDER BY time
),

unisushi AS (
    SELECT uni_vol.time, uni_vol.Uniswap_Volume, sushi_vol.Sushiswap_Volume 
    FROM uni_vol LEFT JOIN sushi_vol ON (uni_vol.time = sushi_vol.time)
),

uni_sushi_balancer AS (
    SELECT unisushi.time, unisushi.Uniswap_Volume, unisushi.Sushiswap_Volume, balancer_vol.Balancer_Volume
    FROM unisushi LEFT JOIN balancer_vol ON (unisushi.time = balancer_vol.time)
),

uni_sushi_balancer_dYdX AS (
    SELECT uni_sushi_balancer.time, uni_sushi_balancer.uniswap_volume, uni_sushi_balancer.sushiswap_volume, uni_sushi_balancer.balancer_volume, dYdX_vol.dYdX_Volume
    FROM uni_sushi_balancer LEFT JOIN dYdX_vol ON (uni_sushi_balancer.time = dYdX_vol.time)
)

SELECT * FROM uni_sushi_balancer_dYdX;
