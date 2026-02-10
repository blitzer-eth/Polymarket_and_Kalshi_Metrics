WITH classification AS (
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
              OR array_position(tags_arr_lc, 'global elections') > 0
              OR question_lc LIKE '%election%' OR question_lc LIKE '%trump%' 
              OR question_lc LIKE '%biden%' OR question_lc LIKE '%kamala%' OR question_lc LIKE '%polls%'
                THEN 'Elections'

            -- 2. Politics
            WHEN array_position(tags_arr_lc, 'politics') > 0 
              OR array_position(tags_arr_lc, 'us politics') > 0
              OR question_lc LIKE '%white house%' OR question_lc LIKE '%senate%' 
              OR question_lc LIKE '%congress%' OR question_lc LIKE '%government shutdown%'
                THEN 'Politics'

            -- 3. Esports (New 18th Category)
            WHEN array_position(tags_arr_lc, 'esports') > 0 
              OR question_lc LIKE '%lol:%' OR question_lc LIKE '%league of legends%' 
              OR question_lc LIKE '%valorant%' OR question_lc LIKE '%t1 %' 
              OR question_lc LIKE '%gen.g%' OR question_lc LIKE '%esports%'
                THEN 'Esports'

            -- 4. Sports (Traditional)
            WHEN array_position(tags_arr_lc, 'sports') > 0 
              OR array_position(tags_arr_lc, 'nba') > 0 OR array_position(tags_arr_lc, 'nfl') > 0
              OR array_position(tags_arr_lc, 'mlb') > 0 OR array_position(tags_arr_lc, 'nhl') > 0
              OR array_position(tags_arr_lc, 'soccer') > 0 OR array_position(tags_arr_lc, 'ufc') > 0
              OR question_lc LIKE '%championship%' OR question_lc LIKE '%playoffs%'
                THEN 'Sports'

            -- 5. Crypto
            WHEN array_position(tags_arr_lc, 'crypto') > 0 
              OR array_position(tags_arr_lc, 'bitcoin') > 0 OR array_position(tags_arr_lc, 'ethereum') > 0
              OR question_lc LIKE '%solana%' OR question_lc LIKE '%microstrategy%' OR question_lc LIKE '%mstr%'
                THEN 'Crypto'

            -- 6. Economics
            WHEN array_position(tags_arr_lc, 'economy') > 0 
              OR array_position(tags_arr_lc, 'inflation') > 0 OR array_position(tags_arr_lc, 'fed') > 0
              OR question_lc LIKE '%interest rate%' OR question_lc LIKE '%cpi%'
                THEN 'Economics'

            -- 7. World (Geopolitics)
            WHEN array_position(tags_arr_lc, 'world') > 0 
              OR array_position(tags_arr_lc, 'geopolitics') > 0
              OR question_lc LIKE '%israel%' OR question_lc LIKE '%ukraine%' OR question_lc LIKE '%china%'
              OR question_lc LIKE '%russia%' OR question_lc LIKE '%iran%' OR question_lc LIKE '%zelenskyy%'
              OR question_lc LIKE '%xi jinping%' OR question_lc LIKE '%khamenei%'
                THEN 'World'

            -- 8. Mentions
            WHEN array_position(tags_arr_lc, 'mentions') > 0 
              OR question_lc LIKE '%say%' OR question_lc LIKE '%tweet%' OR question_lc LIKE '%mention%'
                THEN 'Mentions'

            -- 9. Financials
            WHEN array_position(tags_arr_lc, 'finance') > 0 
              OR question_lc LIKE '%stocks%' OR question_lc LIKE '%s&p 500%' 
              OR question_lc LIKE '%silver (si)%' OR question_lc LIKE '%market cap%'
                THEN 'Financials'

            -- 10. Companies
            WHEN array_position(tags_arr_lc, 'business') > 0 
              OR array_position(tags_arr_lc, 'companies') > 0
              OR question_lc LIKE '%apple%' OR question_lc LIKE '%google%' OR question_lc LIKE '%tesla%'
              OR question_lc LIKE '%nvidia%' OR question_lc LIKE '%spacex%'
                THEN 'Companies'

            -- 11. Science and Technology
            WHEN array_position(tags_arr_lc, 'technology') > 0 OR array_position(tags_arr_lc, 'ai') > 0
              OR question_lc LIKE '%openai%' OR question_lc LIKE '%gemini%' OR question_lc LIKE '%gpt-5%'
                THEN 'Science and Technology'

            -- 12. Climate and Weather
            WHEN array_position(tags_arr_lc, 'weather') > 0 OR question_lc LIKE '%hurricane%' 
              OR question_lc LIKE '%temperature%' OR question_lc LIKE '%hottest on record%'
                THEN 'Climate and Weather'

            -- 13. Entertainment
            WHEN array_position(tags_arr_lc, 'entertainment') > 0 
              OR question_lc LIKE '%movie%' OR question_lc LIKE '%stranger things%' 
              OR question_lc LIKE '%avatar%' OR question_lc LIKE '%wicked%' OR question_lc LIKE '%box office%'
                THEN 'Entertainment'

            -- 14. Social
            WHEN array_position(tags_arr_lc, 'social') > 0 OR array_position(tags_arr_lc, 'culture') > 0
              OR question_lc LIKE '%youtube%' OR question_lc LIKE '%tiktok%' 
              OR question_lc LIKE '%mrbeast%' OR question_lc LIKE '%searched person%'
                THEN 'Social'

            -- 15. Health
            WHEN array_position(tags_arr_lc, 'health') > 0 OR question_lc LIKE '%fda%' 
              OR question_lc LIKE '%virus%' OR question_lc LIKE '%measles%'
                THEN 'Health'

            -- 16. Transportation
            WHEN array_position(tags_arr_lc, 'transportation') > 0 
              OR question_lc LIKE '%boeing%' OR question_lc LIKE '%airline%' OR question_lc LIKE '%flight%'
                THEN 'Transportation'

            -- 17. Education
            WHEN array_position(tags_arr_lc, 'education') > 0 
              OR question_lc LIKE '%university%' OR question_lc LIKE '%college%' OR question_lc LIKE '%school%'
                THEN 'Education'

            ELSE 'Unknown'
        END AS category
    FROM base
)

SELECT 
    m.question, 
    m.tags,
    SUM(p.amount) AS missed_volume
FROM polymarket_polygon.market_trades p
JOIN polymarket_polygon.market_details m 
    ON CAST(p.condition_id AS VARCHAR) = m.condition_id
LEFT JOIN classification c 
    ON c.condition_id = m.condition_id
WHERE c.category = 'Unknown' 
  AND p.block_time >= DATE '2025-01-01'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 100;
