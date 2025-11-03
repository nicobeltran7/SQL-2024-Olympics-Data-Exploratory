WITH hostA AS(SELECT game_slug, game_season, game_end_date, game_start_date, MIN(game_start_date) AS MINDATE, MAX(game_end_date) AS MAXDATE
FROM hosts
GROUP BY game_slug, game_season, game_end_date, game_start_date)
SELECT game_slug, game_season, game_end_date, game_start_date, DATEDIFF(MAXDATE, MINDATE) as Duration
FROM hostA
ORDER BY DATEDIFF(MAXDATE, MINDATE) DESC


WITH hostA AS(SELECT game_slug, game_season, game_end_date, game_start_date, MIN(game_start_date) AS MINDATE, MAX(game_end_date) AS MAXDATE
FROM hosts
GROUP BY game_slug, game_season, game_end_date, game_start_date)
SELECT AVG(DATEDIFF(MAXDATE, MINDATE)) AS AVG
FROM hostA