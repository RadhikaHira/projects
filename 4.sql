SELECT COUNT(title) FROM movies
JOIN ratings on movies.id = ratings.movies_id
WHERE rating = 10;