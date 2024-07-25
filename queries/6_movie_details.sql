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
        'last_name', d.last_name,
        'photo', json_build_object(
            'id', dp.id,
            'file_name', dp.file_name,
            'mime_type', dp.mime_type,
            'file_key', dp.file_key,
            'url_path', dp.url_path
        )
    ) AS "Director",
    (SELECT json_agg(json_build_object(
        'id', a.id,
        'first_name', a.first_name,
        'last_name', a.last_name,
        'photo', json_build_object(
            'id', ap.id,
            'file_name', ap.file_name,
            'mime_type', ap.mime_type,
            'file_key', ap.file_key,
            'url_path', ap.url_path
        )
    )) FROM (
        SELECT person_id FROM characters WHERE movie_id = m.id
        UNION
        SELECT person_id FROM participations WHERE movie_id = m.id
    ) AS all_roles
    JOIN persons a ON all_roles.person_id = a.id
    LEFT JOIN files ap ON a.primary_photo_id = ap.id) AS "Actors",
    (SELECT json_agg(json_build_object(
        'id', g.id,
        'name', g.genre_name
    )) FROM movie_genres mg
    JOIN genres g ON mg.genre_id = g.id
    WHERE mg.movie_id = m.id) AS "Genres"
FROM
    movies m
LEFT JOIN
    files f ON m.poster_id = f.id
LEFT JOIN
    persons d ON m.director_id = d.id
LEFT JOIN
    files dp ON d.primary_photo_id = dp.id
WHERE
    m.id = 1;