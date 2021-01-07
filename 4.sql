SELECT COUNT(title) FROM movies
JOIN rating on movies.id = ratings.movies_id
WHERE rating = 10;