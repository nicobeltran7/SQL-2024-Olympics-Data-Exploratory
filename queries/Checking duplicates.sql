SELECT CONCAT(	discipline_title, slug_game, event_title, event_gender, medal_type, participant_type, athlete_full_name, country_name),
COUNT(CONCAT(discipline_title, slug_game, event_title, event_gender, medal_type, participant_type, athlete_full_name, country_name)) 
    FROM medals
    GROUP BY CONCAT(discipline_title, slug_game, event_title, event_gender, medal_type, participant_type, athlete_full_name, country_name) 
    HAVING COUNT(CONCAT(discipline_title, slug_game, event_title, event_gender, medal_type, participant_type, athlete_full_name, country_name))>1
    
    SELECT COUNT(athlete_full_name) FROM athletes
	GROUP BY athlete_full_name
    HAVING  COUNt(athlete_full_name) >1