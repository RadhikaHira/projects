--list name of top 5 longest songs
--order by descending
SELECT name FROM songs
ORDER BY duration_ms DESC
LIMIT 5;

