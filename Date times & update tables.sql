SELECT *
FROM hosts

SELECT game_start_date, REPLACE(REPLACE(game_start_date,'T',' '),'Z','')
FROM hosts

UPDATE hosts
SET game_start_date = REPLACE(REPLACE(game_start_date,'T',' '),'Z','')

UPDATE hosts
SET game_end_date = REPLACE(REPLACE(game_end_date,'T',' '),'Z','')

