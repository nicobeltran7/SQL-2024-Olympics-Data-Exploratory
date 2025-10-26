SELECT *
FROM medals

UPDATE medals
SET medal_type = LOWER(medal_type)

UPDATE medals
SET athlete_full_name = LOWER(athlete_full_name)

UPDATE athletes
SET athlete_full_name = LOWER(athlete_full_name)