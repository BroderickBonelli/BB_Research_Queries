# BB_Research_Queries

Dune Analytics dashboard can be found at: https://dune.xyz/broderickbonelli/BB-Research-Queries

Research Query 1 - wBTC Supply On Uniswap V2:
Access WBTC reserve info for all pairs containing WBTC on Uniswap V2 using the getReserves table in dune. I wasn't sure if the question was asking for total liquidity or total volume, so I also found the daily total volume of WBTC on Uniswap V2 by accessing dex.trades and aggregating all WBTC volume. 

Research Query 4 - USDC/ETH Liquidity in USD by the minute for Uniswap V2
Find liquidity for USDC/ETH pair in Uniswap V2 by the minute. Accessed liquidity with the getReserves table, joined price data to the table and calculated the total amount of the pool in USD. 

Research Query 6 - Daily Trading Volume for Uniswap, Sushiswap, Balancer and dYdX (past 250 days)
Aggregate daily volume for each DEX using dex.trades table. Join volume data together into one final table. 

