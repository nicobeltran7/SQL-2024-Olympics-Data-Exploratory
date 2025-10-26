SELECT discipline_title, slug_game, COUNT(medal_type)
FROM medals
WHERE slug_game = 'beijing-2022'
GROUP BY discipline_title, slug_game
ORDER BY COUNT(medal_type) DESC