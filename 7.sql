--return average energy of songs by drake
--use artist_id 
SELECT AVG(energy) FROM songs
WHERE artist_id = (SELECT id FROM artists
                    WHERE name = 'Drake');