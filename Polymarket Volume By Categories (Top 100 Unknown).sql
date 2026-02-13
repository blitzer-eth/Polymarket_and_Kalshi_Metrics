WITH tags AS (
    WITH base AS (
        SELECT
            condition_id,
            TRANSFORM(SPLIT(tags, ','), x -> TRIM(LOWER(x))) AS tags_arr_lc,
            LOWER(question) as question_lc
        FROM polymarket_polygon.market_details
    )

    SELECT
        condition_id,
        CASE
            -- 1. Elections
            WHEN array_position(tags_arr_lc, 'elections') > 0 
              OR array_position(tags_arr_lc, 'us election') > 0
              OR array_position(tags_arr_lc, 'midterms') > 0
              OR array_position(tags_arr_lc, 'primaries') > 0
              OR array_position(tags_arr_lc, 'global elections') > 0
              OR array_position(tags_arr_lc, 'mayoral elections') > 0
              OR question_lc LIKE '%election%' OR question_lc LIKE '%polls%'
                THEN 'Elections'

            -- 2. Politics
            WHEN array_position(tags_arr_lc, 'politics') > 0 
              OR array_position(tags_arr_lc, 'us politics') > 0
              OR array_position(tags_arr_lc, 'trump') > 0
              OR array_position(tags_arr_lc, 'epstein') > 0
              OR array_position(tags_arr_lc, 'congress') > 0
              OR array_position(tags_arr_lc, 'minenesota unrest') > 0
              OR array_position(tags_arr_lc, 'courts') > 0
              OR array_position(tags_arr_lc, 'cabinet') > 0
              OR array_position(tags_arr_lc, 'senate') > 0
              OR array_position(tags_arr_lc, 'government') > 0
              OR array_position(tags_arr_lc, 'debt ceiling') > 0
              OR question_lc LIKE '%white house%' OR question_lc LIKE '%government shutdown%'
              OR question_lc LIKE '%trump%' OR question_lc LIKE '%biden%' 
              OR question_lc LIKE '%kamala%' OR question_lc LIKE '%debate%'
              OR question_lc LIKE '%speaker%' OR question_lc LIKE '%jim jordan%'
                THEN 'Politics'

            -- 3. Sports
            WHEN array_position(tags_arr_lc, 'sports') > 0 
              OR array_position(tags_arr_lc, 'nba') > 0 OR array_position(tags_arr_lc, 'nfl') > 0
              OR array_position(tags_arr_lc, 'mlb') > 0 OR array_position(tags_arr_lc, 'nhl') > 0
              OR array_position(tags_arr_lc, 'soccer') > 0 OR array_position(tags_arr_lc, 'ufc') > 0
              OR array_position(tags_arr_lc, 'esports') > 0 OR array_position(tags_arr_lc, 'ncaab') > 0
              OR array_position(tags_arr_lc, 'olympics') > 0 OR array_position(tags_arr_lc, 'winter olympics') > 0
              OR array_position(tags_arr_lc, 'football') > 0 OR array_position(tags_arr_lc, 'basketball') > 0
              OR array_position(tags_arr_lc, 'tennis') > 0 OR array_position(tags_arr_lc, 'baseball') > 0
              OR array_position(tags_arr_lc, 'hockey') > 0 OR array_position(tags_arr_lc, 'cricket') > 0
              OR array_position(tags_arr_lc, 'rugby') > 0 OR array_position(tags_arr_lc, 'golf') > 0
              OR array_position(tags_arr_lc, 'formula 1') > 0 OR array_position(tags_arr_lc, 'chess') > 0
              OR array_position(tags_arr_lc, 'boxing') > 0 OR array_position(tags_arr_lc, 'pickleball') > 0
              OR array_position(tags_arr_lc, 'sport') > 0 OR array_position(tags_arr_lc, 'wnba') > 0
              OR array_position(tags_arr_lc, 'champions league') > 0
              OR question_lc LIKE '%championship%' OR question_lc LIKE '%playoffs%'
              OR question_lc LIKE '%lol:%' OR question_lc LIKE '%league of legends%' 
              OR question_lc LIKE '%valorant%' OR question_lc LIKE '%t1%' 
              OR question_lc LIKE '%gen.g%' OR question_lc LIKE '%apex%'
              OR question_lc LIKE '%super bowl%' OR question_lc LIKE '%nuggets%' OR question_lc LIKE '%djokovic%'
              OR question_lc LIKE '%wimbledon%' OR question_lc LIKE '%fide%'
                THEN 'Sports'

            -- 4. Crypto
            WHEN array_position(tags_arr_lc, 'crypto') > 0 
              OR array_position(tags_arr_lc, 'bitcoin') > 0 OR array_position(tags_arr_lc, 'ethereum') > 0
              OR array_position(tags_arr_lc, 'pre-market') > 0 OR array_position(tags_arr_lc, 'solana') > 0
              OR array_position(tags_arr_lc, 'xrp') > 0 OR array_position(tags_arr_lc, 'dogecoin') > 0
              OR array_position(tags_arr_lc, 'microstrategy') > 0 OR array_position(tags_arr_lc, 'airdrop') > 0
              OR array_position(tags_arr_lc, 'binance') > 0 OR array_position(tags_arr_lc, 'base') > 0
              OR array_position(tags_arr_lc, 'ftx') > 0 OR array_position(tags_arr_lc, 'sbf') > 0
              OR question_lc LIKE '%mstr%' OR question_lc LIKE '%bnb%' OR question_lc LIKE '%link%'
              OR question_lc LIKE '%arb%' OR question_lc LIKE '%airdrop%' OR question_lc LIKE '%usdt%'
              OR question_lc LIKE '%zksync%' OR question_lc LIKE '%opensea%' OR question_lc LIKE '%balaji%'
                THEN 'Crypto'

            -- 5. Economics
            WHEN array_position(tags_arr_lc, 'economy') > 0 
              OR array_position(tags_arr_lc, 'inflation') > 0 OR array_position(tags_arr_lc, 'fed') > 0
              OR array_position(tags_arr_lc, 'trade war') > 0 OR array_position(tags_arr_lc, 'fed rates') > 0
              OR array_position(tags_arr_lc, 'macro indicators') > 0 OR array_position(tags_arr_lc, 'gdp') > 0
              OR array_position(tags_arr_lc, 'global rates') > 0 OR array_position(tags_arr_lc, 'taxes') > 0
              OR array_position(tags_arr_lc, 'treasuries') > 0 OR array_position(tags_arr_lc, 'tsa') > 0
              OR array_position(tags_arr_lc, 'housing') > 0
              OR question_lc LIKE '%interest rate%' OR question_lc LIKE '%cpi%' OR question_lc LIKE '%credit suisse%'
                THEN 'Economics'

            -- 6. World
            WHEN array_position(tags_arr_lc, 'world') > 0 
              OR array_position(tags_arr_lc, 'geopolitics') > 0 OR array_position(tags_arr_lc, 'china') > 0
              OR array_position(tags_arr_lc, 'gaza') > 0 OR array_position(tags_arr_lc, 'israel') > 0
              OR array_position(tags_arr_lc, 'iran') > 0 OR array_position(tags_arr_lc, 'ukraine') > 0
              OR array_position(tags_arr_lc, 'venezuela') > 0 OR array_position(tags_arr_lc, 'middle east') > 0
              OR array_position(tags_arr_lc, 'ukraine map') > 0 OR array_position(tags_arr_lc, 'india-pakistan') > 0
              OR array_position(tags_arr_lc, 'canada') > 0 OR array_position(tags_arr_lc, 'south korea') > 0
              OR array_position(tags_arr_lc, 'yemen') > 0 OR array_position(tags_arr_lc, 'taiwan') > 0
              OR array_position(tags_arr_lc, 'palestine') > 0 OR array_position(tags_arr_lc, 'hamas') > 0
              OR question_lc LIKE '%russia%' OR question_lc LIKE '%iran%' OR question_lc LIKE '%zelenskyy%'
              OR question_lc LIKE '%xi jinping%' OR question_lc LIKE '%khamenei%' OR question_lc LIKE '%hostage%'
              OR question_lc LIKE '%ceasefire%' OR question_lc LIKE '%coup%' OR question_lc LIKE '%intervention%'
                THEN 'World'

            -- 7. Mentions
            WHEN array_position(tags_arr_lc, 'mentions') > 0 
              OR question_lc LIKE '%say%' OR question_lc LIKE '%tweet%' OR question_lc LIKE '%mention%'
                THEN 'Mentions'

            -- 8. Financials
            WHEN array_position(tags_arr_lc, 'finance') > 0 
              OR array_position(tags_arr_lc, 'stocks') > 0 OR array_position(tags_arr_lc, 'earnings') > 0
              OR array_position(tags_arr_lc, 'indices') > 0 OR array_position(tags_arr_lc, 'commodities') > 0
              OR array_position(tags_arr_lc, 'forex') > 0 OR array_position(tags_arr_lc, 'collectibles') > 0
              OR array_position(tags_arr_lc, 'acquisitions') > 0 OR array_position(tags_arr_lc, 'earnings-calls') > 0
              OR array_position(tags_arr_lc, 'ipos') > 0 OR array_position(tags_arr_lc, 'prediction-markets') > 0
              OR array_position(tags_arr_lc, 'financials') > 0
              OR question_lc LIKE '%gold%' OR question_lc LIKE '%s&p 500%' 
              OR question_lc LIKE '%silver (si)%' OR question_lc LIKE '%market cap%'
                THEN 'Financials'

            -- 9. Companies
            WHEN array_position(tags_arr_lc, 'business') > 0 
              OR array_position(tags_arr_lc, 'companies') > 0
              OR question_lc LIKE '%apple%' OR question_lc LIKE '%google%' OR question_lc LIKE '%tesla%'
              OR question_lc LIKE '%nvidia%' OR question_lc LIKE '%spacex%'
                THEN 'Companies'

            -- 10. Science and Technology
            WHEN array_position(tags_arr_lc, 'technology') > 0 
              OR array_position(tags_arr_lc, 'ai') > 0 OR array_position(tags_arr_lc, 'big tech') > 0
              OR array_position(tags_arr_lc, 'science') > 0
              OR question_lc LIKE '%openai%' OR question_lc LIKE '%gemini%' OR question_lc LIKE '%gpt-5%'
              OR question_lc LIKE '%superconductor%' OR question_lc LIKE '%aliens%'
                THEN 'Science and Technology'

            -- 11. Climate and Weather
            WHEN array_position(tags_arr_lc, 'weather') > 0 
              OR question_lc LIKE '%hurricane%' OR question_lc LIKE '%typhoon%'
              OR question_lc LIKE '%space%' OR question_lc LIKE '%earthquakes%'
              OR question_lc LIKE '%global temp%' OR question_lc LIKE '%temperature%' 
              OR question_lc LIKE '%natural disasters%' OR question_lc LIKE '%flooding%'
              OR question_lc LIKE '%fire%' OR question_lc LIKE '%heat%'
                THEN 'Climate and Weather'

            -- 12. Entertainment
            WHEN array_position(tags_arr_lc, 'entertainment') > 0 
              OR array_position(tags_arr_lc, 'awards') > 0 OR array_position(tags_arr_lc, 'oscar') > 0
              OR array_position(tags_arr_lc, 'movies') > 0 OR array_position(tags_arr_lc, 'tv') > 0
              OR question_lc LIKE '%movie%' OR question_lc LIKE '%stranger things%' 
              OR question_lc LIKE '%avatar%' OR question_lc LIKE '%wicked%' OR question_lc LIKE '%box office%'
              OR question_lc LIKE '%barbie%' OR question_lc LIKE '%oppenheimer%' OR question_lc LIKE '%barbenheimer%'
              OR question_lc LIKE '%eras tour%' OR question_lc LIKE '%gta 6%'
                THEN 'Entertainment'

            -- 13. Social
            WHEN array_position(tags_arr_lc, 'social') > 0 OR array_position(tags_arr_lc, 'culture') > 0
              OR question_lc LIKE '%youtube%' OR question_lc LIKE '%tiktok%' 
              OR question_lc LIKE '%mrbeast%' OR question_lc LIKE '%searched person%'
              OR question_lc LIKE '%twitter%' OR question_lc LIKE '%musk vs. zuck%'
              OR question_lc LIKE '%interview%' OR question_lc LIKE '%kanye%' OR question_lc LIKE '%jennifer aniston%'
                THEN 'Social'

            -- 14. Health
            WHEN array_position(tags_arr_lc, 'health') > 0 OR question_lc LIKE '%fda%' 
              OR question_lc LIKE '%virus%' OR question_lc LIKE '%measles%'
                THEN 'Health'

            -- 15. Transportation
            WHEN array_position(tags_arr_lc, 'transportation') > 0 
              OR question_lc LIKE '%boeing%' OR question_lc LIKE '%airline%' OR question_lc LIKE '%flight%'
              OR question_lc LIKE '%submarine%'
                THEN 'Transportation'

            -- 16. Education
            WHEN array_position(tags_arr_lc, 'education') > 0 
              OR question_lc LIKE '%university%' OR question_lc LIKE '%college%' OR question_lc LIKE '%school%'
                THEN 'Education'

            ELSE 'Unknown'
        END AS category
    FROM base
),

filtered_unknowns AS (
    SELECT
        m.question,
        m.tags AS original_tags,
        p.amount
    FROM polymarket_polygon.market_trades p
    JOIN polymarket_polygon.market_details m ON CAST(p.condition_id AS VARCHAR) = m.condition_id
    JOIN tags t ON t.condition_id = m.condition_id
    WHERE t.category = 'Unknown'
      AND CASE 
            WHEN regexp_like(CAST('{{Timeframe}}' AS VARCHAR), '^[0-9]{4}$') 
                THEN CAST(year(CAST(p.block_time AS TIMESTAMP)) AS VARCHAR) = CAST('{{Timeframe}}' AS VARCHAR)
            WHEN LOWER(CAST('{{Timeframe}}' AS VARCHAR)) = 'last 365 days' 
                THEN CAST(p.block_time AS TIMESTAMP) >= NOW() - INTERVAL '365' DAY
            WHEN LOWER(CAST('{{Timeframe}}' AS VARCHAR)) = 'all time' 
                THEN TRUE
            ELSE FALSE
        END
)

-- Final Output: Summary Total + Top 100 List
(
    SELECT 
        '--- GRAND TOTAL UNKNOWN VOLUME ---' AS question, 
        'ALL TAGS' AS original_tags, 
        SUM(amount) AS volume
    FROM filtered_unknowns
)
UNION ALL
(
    SELECT 
        question, 
        original_tags, 
        SUM(amount) AS volume
    FROM filtered_unknowns
    GROUP BY 1, 2
    ORDER BY 3 DESC
    LIMIT 100
)
