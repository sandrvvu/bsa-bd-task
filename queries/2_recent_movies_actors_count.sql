SELECT 
	m.id AS "ID",
	m.title AS "Title",
	COUNT(DISTINCT all_roles.person_id) AS "Actors count"
FROM
	movies m
LEFT JOIN (
	SELECT movie_id, person_id FROM characters
	UNION
	SELECT movie_id, person_id FROM characters
) all_roles ON all_roles.movie_id = m.id
WHERE
	EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM m.release_date) <= 5
GROUP BY 
	m.id, m.title;
	