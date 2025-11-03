SELECT country_name, COUNT(medal_type) AS count
FROM medals
WHERE medal_type = 'gold'
GROUP BY country_name
ORDER BY COUNT(medal_type) DESC