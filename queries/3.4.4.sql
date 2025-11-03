SELECT COUNT(distinct(country_name))
FROM medals
WHERE medal_type = 'gold' AND slug_game = 'tokyo-2020'