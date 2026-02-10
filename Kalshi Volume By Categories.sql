SELECT 
    category, 
    SUM(daily_volume) AS total_volume
FROM kalshi.market_report
WHERE DATE(date) >= NOW() - INTERVAL '{{Days Back}}' DAY
GROUP BY 1
ORDER BY 2 DESC
