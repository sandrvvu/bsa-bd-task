SELECT 
	p.id AS "Director ID",
	p.first_name ||' ' || p.last_name AS "Director name",
	COALESCE(AVG(m.budget), 0) AS "Average budget"
FROM
	persons p
LEFT JOIN 
	movies m ON m.director_id = p.id
GROUP BY 
	p.id, p.first_name, p.last_name;