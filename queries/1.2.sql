SELECT athlete_full_name, COUNT(medal_type)
FROM medals
GROUP BY athlete_full_name
ORDER BY COUNT(medal_type) DESC