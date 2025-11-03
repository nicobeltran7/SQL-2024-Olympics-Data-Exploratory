SELECT *
FROM medals

UPDATE medals
SET athlete_full_name = 'Team'
WHERE athlete_full_name = ''

SELECT*
FROM athletes

SELECT athlete_year_birth, COUNT(ISNULL(athlete_year_birth))
FROM athletes
GROUP BY athlete_year_birth
ORDER BY athlete_year_birth ASC

UPDATE athletes
SET athlete_year_birth = null
WHERE athlete_year_birth = ''

DELETE FROM athletes
WHERE athlete_year_birth = '1900'