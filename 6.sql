SELECT avg(rating) FROM ratings
JOIN movies ON raings.movie_id = movies.id
WHERE year = 2012;