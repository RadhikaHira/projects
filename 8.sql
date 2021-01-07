-- list names of songs that feature other artists
-- has the word "feat." in the song name
SELECT name FROM songs
WHERE name LIKE '%feat.%';