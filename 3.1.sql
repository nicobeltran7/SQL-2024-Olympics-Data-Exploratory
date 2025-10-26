WITH city1 AS (SELECT game_season, LEFT(game_name,char_length(game_name)-5) AS city
FROM hosts)
SELECT city
FROM city1
GROUP BY city
HAVING COUNT(DISTINCT game_season)>1


