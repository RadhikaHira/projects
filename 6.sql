--list names of songs by Post Malone
--use artist_id 
SELECT name FROM songs
WHERE artist_id = (SELECT id FROM artists
                    WHERE name = 'Post Malone');