SELECT 
    category, 
    SUM(daily_volume) AS total_volume
FROM kalshi.market_report
WHERE 
    CASE 
        -- 1. Year Check
        WHEN regexp_like(CAST('{{Timeframe}}' AS VARCHAR), '^[0-9]{4}$') 
            THEN CAST(year(CAST(date AS TIMESTAMP)) AS VARCHAR) = CAST('{{Timeframe}}' AS VARCHAR)
        
        -- 2. Rolling 365 Days Check
        WHEN LOWER(CAST('{{Timeframe}}' AS VARCHAR)) = 'last 365 days' 
            THEN CAST(date AS TIMESTAMP) >= NOW() - INTERVAL '365' DAY
        
        -- 3. All Time Check
        WHEN LOWER(CAST('{{Timeframe}}' AS VARCHAR)) = 'all time' 
            THEN TRUE
            
        ELSE FALSE
    END
GROUP BY 1
ORDER BY 2 DESC
