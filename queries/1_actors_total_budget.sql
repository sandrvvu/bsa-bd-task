SELECT
    p.id AS "ID",
    p.first_name AS "First name",
    p.last_name AS "Last name",
    COALESCE(SUM(m.budget), 0) AS "Total movies budget"
FROM
    persons p
LEFT JOIN
    characters c ON p.id = c.person_id
LEFT JOIN
    participations ps ON p.id = ps.person_id
LEFT JOIN
    movies m ON c.movie_id = m.id
GROUP BY
    p.id, p.first_name, p.last_name;