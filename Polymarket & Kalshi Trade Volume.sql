WITH poly_volume AS (
    SELECT 
        date_trunc('day', block_time) AS day,
        SUM(amount) AS daily_volume 
    FROM polymarket_polygon.market_trades
    WHERE block_time >= now() - interval '{{Days Back:}}' day
    GROUP BY 1
),

kalshi_volume AS (
    SELECT 
        date_trunc('day', CAST(date AS TIMESTAMP)) AS day,
        SUM(price * contracts_traded / 100) AS daily_volume
    FROM kalshi.trade_report
    WHERE CAST(date AS TIMESTAMP) >= now() - interval '{{Days Back:}}' day
    GROUP BY 1
)

SELECT 
    COALESCE(p.day, k.day) AS day,
    COALESCE(p.daily_volume, 0) AS polymarket_vol_usd,
    COALESCE(k.daily_volume, 0) AS kalshi_vol_usd,
    COALESCE(p.daily_volume, 0) + COALESCE(k.daily_volume, 0) AS total_market_volume,
    (COALESCE(p.daily_volume, 0) / NULLIF(COALESCE(p.daily_volume, 0) + COALESCE(k.daily_volume, 0), 0)) * 100 AS polymarket_share_pct
FROM poly_volume p
FULL OUTER JOIN kalshi_volume k ON p.day = k.day
ORDER BY 1 DESC
