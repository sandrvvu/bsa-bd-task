SELECT 
	u.id AS "ID",
	u.username AS "Username",
	ARRAY_AGG(fm.movie_id) AS "Favorite movie IDs"
FROM
	users u
LEFT JOIN favourite_movies fm ON u.id = fm.user_id
GROUP BY
    u.id, u.username; 