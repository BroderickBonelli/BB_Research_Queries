--total supply of WBTC on Uniswap V2
WITH uni_v2_wbtc_supply AS (
    SELECT DATE_TRUNC('day', call_block_time) AS time,
    output__reserve0 / 1e8 AS wbtc
    FROM uniswap_v2."Pair_call_getReserves"
    WHERE contract_address IN (
    '\xcd7989894bc033581532d2cd88da5db0a4b12859', --WBTC/BADGER
    '\xbb2b8038a1640196fbe3e38816f3e67cba72d940', --WBTC/ETH
    '\x231b7589426ffe1b75405526fc32ac09d44364c4', --WBTC/DAI
    '\x004375dff511095cc5a197a54140a24efef3a416', --WBTC/USDC
    '\x7e2b8aa127f6a50715ed4d300a95e6d1d35fd08a', --WBTC/SYLO
    '\xe86204c4eddd2f70ee00ead6805f917671f56c52', --WBTC/DIGG
    '\x69cda6eda9986f7fca8a5dba06c819b535f4fc50', --WBTC/KLONX
    '\xf12c086347a328f3a000d892f23875d886d530cf', --WBTC/renBTC
    '\x5548f847fd9a1d3487d5fbb2e8d73972803c4cce', --WBTC/SWAPP
    '\xc2f71bbca8fc4b8f0646bfe49c2514913f51c328', --WBTC/PEAK
    '\x0731ee4cf7376a1bd5a78199ac9bedc8213def24', --WBTC/wPE
    '\x56b9f76ae3c872818f9250a700a2626240ae0169', --WBTC/WDOGE
    '\x0de0fa91b6dbab8c8503aaa2d1dfa91a192cb149', --WBTC/USDT
    '\x4500d866bedb9d8fc280924b31c76dacf7979cae', --WBTC/MATIC
    '\x1f3d61248ec81542889535595903078109707941', --WBTC/KBTC
    '\x9f8d8df26d5ab71b492ddce9799f432e36c289df', --WBTC/pBTC
    '\x7ac54407a88599612b7ed37cc3144242d1006bcb', --WBTC/SOTU
    '\x4f650832d07896e31d65b5acec55b72d2afc5abf', --WBTC/USDN
    '\x44b77e9ce8a20160290fcbaa44196744f354c1b7', --WBTC/DYP
    '\xfb4717730bd51736af3f19f05473bd89f7b23190', --WBTC/BMI
    '\x39993cf130593b571165f4f932799d3bcb62a1d2', --WBTC/XPR
    '\xee51984781254ad1a0ee3ae0ca26c4d53dea6ecb', --WBTC/ISLA
    '\x7e2a722fc51b0f693f0c60a43e656787f27509ab' --WBTC/nWBTC
)

UNION

SELECT DATE_TRUNC('day', call_block_time) AS time,
output__reserve1 / 1e8 AS wbtc
FROM uniswap_v2."Pair_call_getReserves"
WHERE contract_address IN (
'\x888759cb22cedadf2cfb0049b03309d45aa380d9', --ARMOR/WBTC
'\xb8d6d631aee8c67473ab362c6fd9dd94c95de7f0', --DENA/WBTC
'\xea900eb2ef3d059e8c4ba2df138053122e89c73f', --RBTC/WBTC
'\x01d8249d7c7a6058060bef027adda0b529035ff5', --LUCO/WBTC
'\xaa873c9da6541f13c89416c17271b4c21bf7b2d7' --UNI/WBTC
)
GROUP BY time, wbtc
ORDER BY time)

SELECT DATE_TRUNC('day', time) as time,
AVG(wbtc) as WBTC
FROM uni_v2_wbtc_supply
GROUP BY time
ORDER BY time;



-- -- -- WBTC volume on Uniswap V2
-- WITH uni_v2_wbtc AS (
-- SELECT DATE_TRUNC('day', block_time) AS day,
-- SUM(CASE WHEN token_a_symbol = 'WBTC' THEN token_a_amount ELSE 0 END) AS wbtc_amount_a,
-- SUM(CASE WHEN token_b_symbol = 'WBTC' THEN token_b_amount ELSE 0 END) AS wbtc_amount_b
-- FROM dex.trades
-- WHERE project = 'Uniswap'
-- AND version = '2'
-- GROUP BY day
-- ORDER BY day
-- )

-- SELECT uni_v2_wbtc.day AS day, 
-- uni_v2_wbtc.wbtc_amount_a + uni_v2_wbtc.wbtc_amount_b AS total_wbtc
-- FROM uni_v2_wbtc;


