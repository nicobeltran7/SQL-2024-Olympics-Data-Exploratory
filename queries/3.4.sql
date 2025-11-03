WITH medals AS (SELECT COUNT(DISTINCT(country_name)) AS totalcountry, slug_game, medal_type
FROM medals
GROUP BY slug_game, medal_type)
SELECT DISTINCT slug_game, SUM(totalcountry), COUNT(medal_type)
FROM medals
WHERE slug_game = 'tokyo-2020'
GROUP BY slug_game, totalcountry
HAVING COUNT(medal_type) >=1
ORDER BY COUNT(medal_type) DESC

SELECT SUM(country_count) AS total_countries_with_medals
FROM (SELECT COUNT(DISTINCT country_name) AS country_count
    FROM medals
    WHERE medal_type IS NOT NULL
    GROUP BY country_name
    HAVING COUNT(medal_type) >= 1
) subquery;

