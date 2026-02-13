WITH timeframe_param AS (
    SELECT '{{Timeframe}}' AS val
),

kalshi_total AS (
    SELECT 
        'Kalshi' AS market,
        SUM(daily_volume) / 1e9 AS total_volume_billions
    FROM kalshi.market_report
    CROSS JOIN timeframe_param tp
    WHERE 
        CASE 
            WHEN regexp_like(CAST(tp.val AS VARCHAR), '^[0-9]{4}$') 
                THEN CAST(year(CAST(date AS TIMESTAMP)) AS VARCHAR) = CAST(tp.val AS VARCHAR)
            WHEN LOWER(CAST(tp.val AS VARCHAR)) = 'last 365 days' 
                THEN CAST(date AS TIMESTAMP) >= NOW() - INTERVAL '365' DAY
            WHEN LOWER(CAST(tp.val AS VARCHAR)) = 'all time' 
                THEN TRUE
            ELSE FALSE
        END
),

poly_total AS (
    SELECT 
        'Polymarket' AS market,
        SUM(amount) / 1e9 AS total_volume_billions
    FROM polymarket_polygon.market_trades p
    CROSS JOIN timeframe_param tp
    WHERE 
        CASE 
            WHEN regexp_like(CAST(tp.val AS VARCHAR), '^[0-9]{4}$') 
                THEN CAST(year(CAST(p.block_time AS TIMESTAMP)) AS VARCHAR) = CAST(tp.val AS VARCHAR)
            WHEN LOWER(CAST(tp.val AS VARCHAR)) = 'last 365 days' 
                THEN CAST(p.block_time AS TIMESTAMP) >= NOW() - INTERVAL '365' DAY
            WHEN LOWER(CAST(tp.val AS VARCHAR)) = 'all time' 
                THEN TRUE
            ELSE FALSE
        END
)

SELECT market, total_volume_billions FROM kalshi_total
UNION ALL
SELECT market, total_volume_billions FROM poly_total;
