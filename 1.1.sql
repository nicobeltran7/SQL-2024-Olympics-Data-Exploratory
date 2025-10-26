SELECT m.slug_game, COUNT(m.medal_type)
FROM medals m
WHERE m.slug_game = 'tokyo-2020'
GROUP BY m.Slug_game


SELECT m.slug_game, COUNT(m.medal_type)
FROM medals m
WHERE m.slug_game = 'tokyo-2020'
	AND m.medal_type = 'gold'
GROUP BY m.Slug_game