SELECT 
	m.id AS "ID",
	m.title AS "Title",
	m.release_date AS "Release date",
	m.duration AS "Duration",
	m.details AS "Description",
 json_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'file_key', f.file_key,
        'url_path', f.url_path
    ) AS "Poster",
    json_build_object(
        'id', d.id,
        'first_name', d.first_name,
        'last_name', d.last_name
    ) AS "Director"
FROM
    movies m
LEFT JOIN
    files f ON m.poster_id = f.id
LEFT JOIN
    persons d ON m.director_id = d.id
LEFT JOIN
    movie_genres mg ON m.id = mg.movie_id
LEFT JOIN
    genres g ON mg.genre_id = g.id
WHERE
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > 135
    AND g.genre_name IN ('Action', 'Drama')
GROUP BY
    m.id, f.id, d.id, g.genre_name
HAVING
    COUNT(DISTINCT g.id) > 0;